//
//  QuestionsGameApp.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import SwiftUI

@main
struct QuestionsGameApp: App {
    let store = AppStore(initial: AppState(), reducer: AppReducer)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
