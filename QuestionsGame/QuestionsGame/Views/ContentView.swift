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
                        .padding(.bottom, 24)
                        .accessibilityIdentifier("CategoryListView")

                    MonsterBattleCardListView()
                        .padding(.bottom, 17)
                        .accessibilityIdentifier("MonsterBattleCardListView")

                    ButtonView()
                        .accessibilityIdentifier("StartButtonView")

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
                    let questions = (data as! [Question])
                    store.dispatch(.setQuestions(questions))

                case .failure:
                    store.dispatch(.setQuestions([]))
                }
            }
        }.animation(.spring())
    }
}

#if !TESTING
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = AppStore(
            initial: AppState(),
            reducer: AppReducer
        )
        
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(store)
    }
}
#endif
