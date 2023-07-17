//
//  Answer.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import Foundation

class Answer: Codable {
    var option: Int
    var answer: String
    var correct: Bool
    
    init(option: Int, answer: String, correct: Bool) {
        self.option = option
        self.answer = answer
        self.correct = correct
    }
}