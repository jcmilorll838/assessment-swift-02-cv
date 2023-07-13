//
//  Answer.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import Foundation

class Answer: Codable, Identifiable {
    var answer: String
    var correct: Bool
}