//
//  RadioButtonGroupView.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 14/07/23.
//

import SwiftUI

struct RadioButton: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.colorScheme) var colorScheme

    let answer: Answer
    let callback: (String)->()
    let selectedID : String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat

    init(
        answer: Answer,
        callback: @escaping (String)->(),
        selectedID: String,
        size: CGFloat = 20,
        color: Color = Color.primary,
        textSize: CGFloat = 14
        ) {
        self.answer = answer
        self.size = size
        self.color = color
        self.textSize = textSize
        self.selectedID = selectedID
        self.callback = callback
    }
    
    func isSelected() -> Bool{
        return String(answer.option) == selectedID
    }
    
    func buttonColor(selected: Bool) -> Color? {
        return selected ?
            Color(hex: "#BB86FC") :
            Color(hex: "#6200EE")
    }

    var body: some View {
        Button(action:{
            self.callback(String(self.answer.option))
            store.state.currentQuestion?.setAnswer(answer: self.answer)
            var score = 0
            if(self.answer.correct){
                score = store.state.timeRemaining
            }
            store.state.currentQuestion?.setScore(score: score)
            store.dispatch(.setRunning(false))
            store.dispatch(.setSelectedAnswer(self.answer.option))
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.selectedID == String(self.answer.option) ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(answer.answer)
                    .font(Font.system(size: 14))
                Spacer()
            }.foregroundColor(.white)
        }
        .padding(5)
        .background(buttonColor(selected: isSelected()))
        .foregroundColor(.white)
        .cornerRadius(5)
        .frame(height: 35)
        .disabled(!store.state.timerRunning)
    }
}

struct RadioButtonGroupView: View {

    let items : [Answer]
    @EnvironmentObject var store: AppStore

    let callback: (String) -> ()

    var body: some View {
        VStack(spacing:1) {
            ForEach(0..<items.count) { index in
                RadioButton(answer: self.items[index], callback: self.radioGroupCallback, selectedID: String(store.state.selectedAnswer))
            }
        }.padding(.all, 10)
    }

    func radioGroupCallback(id: String) {
        callback(id)
    }
}

struct RadioButtonGroupView_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonGroupView(items: [Answer(option:1, answer:"1", correct: true), Answer(option:2, answer:"2", correct: false)]) { selected in
                        print("Selected is: \(selected)")
                    }
    }
}
