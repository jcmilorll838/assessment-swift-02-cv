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
    let total: Float = Float(numbers.count)
    var pos: Float = 0
    var neg: Float = 0
    var zero: Float = 0

    numbers.forEach { number in
        if (number > 0){ pos += 1 }
        else if (number < 0){ neg += 1 }
        else { zero += 1 }
    }


    return [
        .positives: String(format: "%.6f", pos/total),
        .negative: String(format: "%.6f", neg/total),
        .zeros: String(format: "%.6f", zero/total)
    ]
}
