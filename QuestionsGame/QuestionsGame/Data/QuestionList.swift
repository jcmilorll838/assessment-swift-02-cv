//
//  QuestionList.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 14/07/23.
//

import SwiftUI

class QuestionList {
    var questions: [Question] = (Bundle.main.decode("questions.json") as [Question])
}
