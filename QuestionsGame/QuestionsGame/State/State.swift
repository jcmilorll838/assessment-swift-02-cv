//
//  State.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import Foundation

struct AppState {
    var categories: [Category] = []
    var questions: [Question] = []
    var questionsByCategory: [Question] = []
    var currentQuestion: Question?
    var selectedCategory: Category?
    var timeRemaining: Int = 0
    var timerRunning: Bool = false
    var categoryScore: Int = 0
    var showScore: Bool = false
    var selectedAnswer: Int = 0
}
