//
//  Question.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import Foundation

class Question: Codable, Identifiable {
    var id: Int
    var question: String
    var imageUrl: URL
    var category: String
    var time: Int
    var answers: [Answer]
    
}
