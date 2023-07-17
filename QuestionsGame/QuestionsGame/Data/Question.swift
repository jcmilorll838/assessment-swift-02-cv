//
//  Question.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 14/07/23.
//

import Foundation

class Question: Codable, Identifiable {
    var id: Int
    var question: String
    var imageUrl: URL
    var category: String
    var time: Int
    var answers: [Answer]
    var answer: Answer?
    var score: Int?


     func setAnswer(answer: Answer? = nil){
        self.answer = answer
    }

    func setScore(score: Int? = nil){
        self.score = score
    }
}


