//
//  QuestionCardView.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import SwiftUI

struct QuestionCardView: View {
    var defaultName: String
    var question: Question?
    @EnvironmentObject var store: AppStore
    @State var timeRemaining: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    init(defaultName: String, question: Question? = nil, timeRemaining: Int) {
        self.defaultName = defaultName
        self.question = question
        self.timeRemaining = timeRemaining
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if let question =
                self.question
            {
                
                VStack(alignment: .leading, spacing: 7) {
                    
                    Text(question.question)
                        .font(.system(size: 18, weight: .regular))
                        .multilineTextAlignment(.center)
                        .frame(height: 80)
                    HStack(alignment: .center){
                        Spacer()
                        AsyncImage(url: URL(string: question.imageUrl.absoluteString)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 136, height: 99)
                        
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .shadow(color: .black.opacity(0.25), radius: 7, x: 0, y: 0)
                        Spacer()
                    }
                    
                    HStack(alignment: .center){
                        Spacer()
                        Text("Time: \(store.state.timeRemaining)")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .background(.black.opacity(0.75))
                            .clipShape(Capsule())
                            .onReceive(timer) { time in
                                if store.state.timeRemaining > 0 && store.state.timerRunning{
                                    timeRemaining = store.state.timeRemaining - 1
                                    store.dispatch(.setTime(timeRemaining))
                                }
                            }
                        Spacer()
                    }
                    
                    RadioButtonGroupView(items: question.answers) { selected in
                        print("Selected is: \(selected)")
                    }
                }
                .padding(.all, 10)
                
            } else {
                VStack(alignment: .leading) {
                    Text(self.defaultName)
                        .font(.system(size: 36, weight: .regular))
                        .multilineTextAlignment(.center)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .center
                        )
                }
            }

            Spacer()
        }
        .frame(width: 255, height: 400)
        .background(Color.white)
        .cornerRadius(7)
        .shadow(color: .black.opacity(0.25), radius: 7, x: -2, y: 3)
    }}

#if !TESTING
struct QuestionCardView_Previews: PreviewProvider {
    static var previews: some View {
        let questions = QuestionList().questions

        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            QuestionCardView(
                defaultName: "Question",
                question: questions[0],
                timeRemaining: questions[0].time
            )
        }
    }
}
#endif
