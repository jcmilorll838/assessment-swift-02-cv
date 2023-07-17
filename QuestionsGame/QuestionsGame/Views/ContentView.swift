//
//  ContentView.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: AppStore
    
    let apiClient: APIClient = MockAPIClient()

    var body: some View {
        ScrollView {
            ZStack {
                VStack(alignment: .leading) {
                    ScreenTitleView(title: "Questions Game", size: 36, font: .largeTitle)
                        .padding(.bottom, 17)
                        .accessibilityIdentifier("TitleTextView")

                    ScreenTitleView(title: "Select your Category", size: 24, font: .title2)
                        .padding(.bottom, 4)
                        .accessibilityIdentifier("SubTitleTextView")

                    CategoryListView()
                        .padding(.bottom, 10)
                        .accessibilityIdentifier("CategoryListView")

                    HStack(alignment: .center){
                        Spacer()
                        QuestionCardView(defaultName: "Question", question: store.state.currentQuestion, timeRemaining: store.state.timeRemaining
                        )
                        .accessibilityIdentifier("CurrentQuestionCard")
                        Spacer()
                    }
                   

                    if store.state.showScore
                    {
                        ScoreView(score: String(store.state.categoryScore))
                            .accessibilityIdentifier("ScoreView")
                    } else {
                        ButtonView()
                            .accessibilityIdentifier("ActionButtonView")
                    }
                    
                    Spacer()
                }
                .padding(.all, 20)
            }
        }
        .preferredColorScheme(.light)
        .onAppear() {
            let url = "http://localhost:8090/questions"
            
            self.apiClient.sendRequest(url: url, method: "GET", body: nil, forResource: nil)
            { (result) in
                switch result {
                case .success(let data):
                    print(data)
                    let questions = (data as! [Question])
                    print(questions)
                    store.dispatch(.setQuestions(questions))
                case .failure:
                    
                    let questionsF = QuestionList().questions
                    print(questionsF)
                    store.dispatch(.setQuestions(questionsF))
                }
            }
        }.animation(.spring())
    }
}

#if !TESTING
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let previewStore: AppStore = {
            let store = AppStore.preview
            
            let questions = QuestionList().questions
        
            store.dispatch(.setQuestions(questions))
            
            return store
        }()
        
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(previewStore)
    }
}
#endif
