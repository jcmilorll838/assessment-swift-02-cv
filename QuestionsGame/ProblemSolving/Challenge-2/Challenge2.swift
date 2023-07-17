//
//  Challenge2.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import Foundation

enum DiceError: Error {
    case OutOfRangeException
}
// For each error type return the appropriate localized description
extension DiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .OutOfRangeException:
            return NSLocalizedString(
                "Dice out of number range",
                comment: "Dice out of number range"
            )
        }
    }
}

func diceFacesCalculator(dice1: Int, dice2: Int, dice3: Int) throws -> Int {
    throw DiceError.OutOfRangeException
}
