//
//  Services.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import Foundation

protocol Services {
    func getQuestions(forResource: String, completion: @escaping (Result<Data, Error>) -> Void)
    // func postBattle(body: [String : String?]?, completion: @escaping (Result<Data, Error>) -> Void)
}

struct QuestionsGameServices: Services {
    func getQuestions(forResource: String, completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            guard let fileURL = Bundle.main.url(forResource: forResource, withExtension: "json") else {
                throw NSError(domain: "", code: 400, userInfo: [ NSLocalizedDescriptionKey: "Data was not retrieved from request"])
            }
            let data = try! Data(contentsOf: fileURL)
            let questions = try JSONDecoder().decode([Question].self, from: data)
            completion(.success(try JSONEncoder().encode(questions)))
        } catch {
            completion(.failure(error))
        }
    }

    // func postBattle(body: [String : String?]?, completion: @escaping (Result<Data, Error>) -> Void) {
    //     let monsters = MonsterList().monsters
        
    //     do {
    //         guard let requestBody = body else {
    //             throw NSError(domain: "", code: 400, userInfo: [ NSLocalizedDescriptionKey: "Missing Request Body"])
    //         }
            
    //         if !requestBody.keys.contains("monster1Id") || !requestBody.keys.contains("monster2Id") {
    //             throw NSError(domain: "", code: 400, userInfo: [ NSLocalizedDescriptionKey: "Missing ID"])
    //         }
            
    //         if let monster1 = monsters.first(where: { $0.id ==
    //             requestBody["monster1Id"]
    //         }), let monster2 =  monsters.first(where: { $0.id ==
    //             requestBody["monster2Id"]
    //         }) {
    //             let monster1Sum =
    //                 monster1.attack + monster1.defense + monster1.hp + monster1.speed;
    //             let monster2Sum =
    //                 monster2.attack + monster2.defense + monster2.hp + monster2.speed;

    //             if monster1Sum > monster2Sum {
    //                 let newBattle = Battle(winner: monster1, tie: false)
    //                 completion(.success(try JSONEncoder().encode(newBattle)))
    //             }

    //             if monster2Sum > monster1Sum {
    //                 let newBattle = Battle(winner: monster2, tie: false)
    //                 completion(.success(try JSONEncoder().encode(newBattle)))
    //             }

    //             if monster1Sum == monster2Sum {
    //                 let newBattle = Battle(winner: nil, tie: true)
    //                 completion(.success(try JSONEncoder().encode(newBattle)))
    //             }
    //         } else {
    //             throw NSError(domain: "", code: 400, userInfo: [ NSLocalizedDescriptionKey: "Invalid ID"])
    //         }
    //     } catch {
    //         completion(.failure(error))
    //     }
    // }
}
