//
//  Question.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import Foundation

class Question: Codable, Identifiable {
    var id = String
    var question: String
    var category: String
    var time: Int
    var imageUrl: URL
    var answers: [Answer]
    var answers: Answer?
    
    /*
    init(answer: Answer? = nil, imageUrl: URL) {
        self.answer = answer
        self.imageUrl = imageUrl
    }
    */
}