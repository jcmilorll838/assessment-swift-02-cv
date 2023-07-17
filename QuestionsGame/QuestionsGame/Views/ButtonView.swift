//
//  ButtonView.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import SwiftUI

struct ButtonView: View {
    @EnvironmentObject var store: AppStore

    let apiClient: APIClient = MockAPIClient()
    
    func isDisabled() -> Bool{
        return store.state.currentQuestion == nil
    }
    
    func isLast(index: Int) -> Bool{
        return index == (store.state.questionsByCategory.count - 1)
    }
    
    func buttonColor(disabled: Bool) -> Color? {
        return disabled ?
            Color(hex: "#BB86FC") :
            Color(hex: "#6200EE")
    }
    
    func getIndex() -> Int{
        return store.state.questionsByCategory.firstIndex(where:{ $0.id == store.state.currentQuestion?.id}) ?? 0
    }

    var body: some View {
        Button {
            let index = getIndex()
            if(!isLast(index: index)){
                store.dispatch(.setCurrent(store.state.questionsByCategory[index+1]))
            } else {
                let questions = store.state.questionsByCategory
                var score = 0
                questions.forEach { question in
                    score += question.score ?? 0
                }
                store.dispatch(.setCategoryScore(score))
            }
            
        } label: {
            Text(isLast(index:getIndex()) ? "Show score" : "Next Question")
                .font(.system(size: 18, weight: .regular))
                .frame(maxWidth: .infinity, maxHeight: 56)
        }
        .background(buttonColor(disabled: isDisabled()))
        .foregroundColor(.white)
        .cornerRadius(5)
        .frame(height: 56)
        .disabled(isDisabled())
    }
}

#if !TESTING
struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let previewStore: AppStore = {
            let store = AppStore.preview
            
            let questions = QuestionList().questions
            let question = questions.randomElement()
            let categories: [Category] = [Category(name: question!.category , imageUrl: question!.imageUrl )]
      
            
            store.dispatch(.setQuestions(questions))
            store.dispatch(.setSelected(categories[0]))
            
            return store
        }()

        ButtonView()
            .frame(alignment: .center)
            .environmentObject(previewStore)
    }
}
#endif
