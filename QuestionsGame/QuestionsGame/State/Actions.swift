//
//  Actions.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import Foundation

enum AppActions {
  case setQuestions([Question])
  case setCurrent(Question?)
  case setSelected(Category?)
  case setTime(Int)
  case setRunning(Bool)
  case setCategoryScore(Int)
  case setSelectedAnswer(Int)
}
