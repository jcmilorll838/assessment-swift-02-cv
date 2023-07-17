//
//  Category.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import Foundation

class Category: Codable, Identifiable {
    var id = UUID()
    var name: String
    var imageUrl: URL
    var score: Int?

    init(name: String, imageUrl: URL, score: Int? = nil) {
        self.name = name
        self.imageUrl = imageUrl
        self.score = score
    }
}