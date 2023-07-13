//
//  Reducer.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import Foundation

typealias Reducer<State, Action> = (State, Action) -> State

let AppReducer: Reducer<AppState, AppActions> = { state, action in
  var mutatingState = state

  switch action {
  case .setSelected(let newSelectedQuestion):
      mutatingState.selectedQuestion = newSelectedQuestion
    
  case .setQuestions(let newQuestions):
      mutatingState.questions = newQuestions
  }

  return mutatingState
}
