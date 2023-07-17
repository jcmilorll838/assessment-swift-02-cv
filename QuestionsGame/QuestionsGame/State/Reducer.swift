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
  case .setCurrent(let newQuestion):
      mutatingState.currentQuestion = newQuestion
      if let currentQuestion = newQuestion {
          mutatingState.timeRemaining = currentQuestion.time
          mutatingState.timerRunning = true
          mutatingState.selectedAnswer = 0
      }
      
  case .setTime(let newTime):
      mutatingState.timeRemaining = newTime

  case .setRunning(let newTimerRunning):
      mutatingState.timerRunning = newTimerRunning
      
  case .setSelectedAnswer(let newAnswer):
      mutatingState.selectedAnswer = newAnswer
  
  case .setCategoryScore(let newScore):
      mutatingState.categoryScore = newScore
      mutatingState.showScore = true
      
  case .setSelected(let newSelectedCategory):
      mutatingState.selectedCategory = newSelectedCategory
      if let selectedCategory = newSelectedCategory {
          let filteredQuestions = mutatingState.questions.filter {
              $0.category == selectedCategory.name
          }
          mutatingState.questionsByCategory = filteredQuestions
          mutatingState.currentQuestion = filteredQuestions[0]
          mutatingState.timeRemaining = filteredQuestions[0].time
          mutatingState.timerRunning = true
          mutatingState.selectedAnswer = 0
          mutatingState.showScore = false
      }
    
  case .setQuestions(let newQuestions):
      mutatingState.questions = newQuestions
      let defaultURL: URL = URL(string: "https://live.staticflickr.com/7312/28222753271_5144638a2a_c.jpg")!
      var categories: Set<String> = []
      mutatingState.questions.forEach{
        categories.insert($0.category)
      }
      let categoryList: [Category] = categories.map { category in
        let questionsByCategory = mutatingState.questions.filter {
            $0.category == category
        }
        return Category(name: category, imageUrl: questionsByCategory.randomElement()?.imageUrl ?? defaultURL)
      }  
      mutatingState.categories = categoryList
  } 

  

  return mutatingState
}
