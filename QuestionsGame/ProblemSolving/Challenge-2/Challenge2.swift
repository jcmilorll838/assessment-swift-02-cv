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
    let dices = [dice1, dice2, dice3]
    let isNotInRange: (Int) -> Bool = {dice in dice > 6 || dice < 1}
    let isNotValidDice = dices.contains(where: isNotInRange)

    if(isNotValidDice){
        throw DiceError.OutOfRangeException
    }

    let repeatedValues = dices.filter {item in
        dices.firstIndex(of: item) != dices.lastIndex(of: item)
    }

    return repeatedValues.isEmpty ? dices.max()! : repeatedValues[0] * repeatedValues.count 
    
}
