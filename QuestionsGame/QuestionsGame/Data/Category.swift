//
//  Category.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import Foundation

class Category: Codable, Identifiable {
    var name: String
    var imageUrl: URL
    var score: Int
}