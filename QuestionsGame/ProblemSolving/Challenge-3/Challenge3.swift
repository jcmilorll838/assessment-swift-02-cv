//
//  Challenge3.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import Foundation

struct Coordinate {
    let x: Int
    let y: Int
    let distance: Int
}

func findLessCostPath(board: [[Int]]) -> Int {
    let numberOfRows = board.count
    let numberOfColumns = board[0].count

    let isAllowedMove: (Int, Int) -> Bool = { x, y in
        x >= 0 && x < numberOfRows && y >= 0 && y < numberOfColumns
    }

    let movesRow = [-1, 0, 1, 0]
    let movesColum = [0, 1, 0, -1]

    var distances = [[Int]](repeating: [Int](repeating: Int.max, count: numberOfColumns), count: numberOfRows)

    distances[0][0] = board[0][0]

    var passedCoordinates = [Coordinate]()
    passedCoordinates.append(Coordinate(x: 0, y: 0, distance: board[0][0]))

    while !passedCoordinates.isEmpty {
        let topCoordinate = passedCoordinates.remove(at: 0)

        for(index, row) in movesRow.enumerated() {
            let targetX = topCoordinate.x + row
            let targetY = topCoordinate.y + movesColum[index]

            if isAllowedMove(targetX, targetY) && distances[targetX][targetY] > distances[topCoordinate.x][topCoordinate.y] + board[targetX][targetY] {
                distances[targetX][targetY] = distances[topCoordinate.x][topCoordinate.y] + board[targetX][targetY]

                passedCoordinates.append(Coordinate(x: targetX, y: targetY, distance: distances[targetX][targetY]))
            }
        }

        passedCoordinates.sort {
            $0.distance < $1.distance || ($0.distance == $1.distance && ($0.x < $1.x || ($0.x == $1.x && $0.y < $1.y)))
        }
    }

    return distances[numberOfRows - 1][numberOfColumns - 1] - board[numberOfRows - 1][numberOfColumns - 1]

}
