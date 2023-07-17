//
//  Challenge1.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import Foundation

enum ReturnKeys: String {
case positives = "positives"
case negative = "negative"
case zeros =  "zeros"
}

func numbersFractionCalculator(numbers: [Int]) -> Dictionary<ReturnKeys, String> {
    return [
        .positives: "0.000000",
        .negative: "0.000000",
        .zeros: "0.000000"
    ]
}
