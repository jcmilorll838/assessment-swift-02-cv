//
//  AppStoreExtension.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import Foundation

extension AppStore {
  static var preview: AppStore {
    AppStore(
      initial: AppState(),
      reducer: AppReducer
    )
  }
}
