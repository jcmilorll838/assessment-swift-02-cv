//
//  MockAPIClient.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import Foundation
import Combine

protocol APIClient {
    func sendRequest(url: String, method: String, body: [String : String?]?, forResource: String?, completion: @escaping (Result<Any, Error>) -> Void)
}

struct MockAPIClient: APIClient {
    private var session: URLSession
    
    init(using session: URLSession = URLSession.shared) {
        if ProcessInfo.processInfo.environment["ISTESTING"] == "true" {
            // Your code that should run under tests
            // Set url session for mock networking
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [URLProtocolMock.self]
            self.session = URLSession(configuration: configuration)
        } else {
            self.session = session

        }
    }

    func getQuestions(url: URL, forResource: String, completion: @escaping (Result<[Monster], Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        if ProcessInfo.processInfo.environment["ISTESTING"] == "true" {
            // Your code that should run under tests
            let services = QuestionsGameServices()
            
            services.getQuestions(forResource: forResource){ (result) in
                switch result {
                case .success(let data):
                    URLProtocolMock.requestHandler = { request in
                        return (HTTPURLResponse(), data)
                    }
                case .failure(let error):
                    URLProtocolMock.requestHandler = { request in
                        throw error
                    }
                }
            }
        }

        let task = self.session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if let questionData = data {
                if let questions = try? JSONDecoder().decode([Question].self, from: questionData) {
                    completion(.success(questions))
                }
            }
            else {
                if let requestError = error {
                    completion(.failure(requestError))
                }
            }
        })

        task.resume()
    }

    func sendRequest(url: String, method: String, body: [String : String?]?, forResource: String?, completion: @escaping (Result<Any, Error>) -> Void) {
        let requestURL = URL(string: url)!
        let endpoint = requestURL.path

        switch endpoint {
        case "/questions":
            getQuestions(url: requestURL, forResource: forResource ?? "questions"){ (result) in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        default:
            completion(.failure(NSError(domain: "", code: 404, userInfo: [ NSLocalizedDescriptionKey: "URL does not exist."])))
        }
    }
}
