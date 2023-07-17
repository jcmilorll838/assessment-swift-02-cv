//
//  Services.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import Foundation

protocol Services {
    func getQuestions(forResource: String, completion: @escaping (Result<Data, Error>) -> Void)
}

struct QuestionsGameServices: Services {
    func getQuestions(forResource: String, completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            guard let fileURL = Bundle.module.url(forResource: forResource, withExtension: "json") else {
                throw NSError(domain: "", code: 400, userInfo: [ NSLocalizedDescriptionKey: "Data was not retrieved from request"])
            }
            let data = try! Data(contentsOf: fileURL)
            let questions = try JSONDecoder().decode([Question].self, from: data)
            completion(.success(try JSONEncoder().encode(questions)))
        } catch {
            completion(.failure(error))
        }
    }
}
