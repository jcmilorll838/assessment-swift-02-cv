//
//  MockAPIClientTests.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import XCTest
@testable import QuestionsGame

class MockAPIClientTests: XCTestCase {
    var apiClient: APIClient!
    var services = QuestionsGameServices()
    
    override func setUp() {
        self.apiClient = MockAPIClient()
    }
    
    func testInvalidURLSendRequest() {
        let expectation = XCTestExpectation(description: "Throw an Error for an invalid URL")

        let url = "http://yourserver.com/invalid"

        self.apiClient.sendRequest(url: url, method: "GET", body: nil, forResource: nil){ (result) in
            switch result {
            case .success(let value):
                XCTFail("Expected to be a failure but got a success with \(value)")
            case .failure(let resultError):
                XCTAssertEqual(resultError.localizedDescription, "URL does not exist.")
                expectation.fulfill()
            }
        }
    }

    func testResultSuccessGetQuestions() {
        let expectation = XCTestExpectation(description: "Return a list of 2 questions")

        let url = "http://yourserver.com/questions"
        
        let forResource = "questions"
        
        self.apiClient.sendRequest(url: url, method: "GET", body: nil, forResource: forResource){ (result) in
            switch result {
            case .success(let data):
                let questions = (data as! [Question])
                XCTAssertEqual(questions.count, 2)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected to be a success but got a failure with \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testResulFailGetQuestions() {
        let expectation = XCTestExpectation(description: "Throw an Error for an invalid file path")

        let url = "http://yourserver.com/questions"
        
        let forResource = "unknownFile"
        
        self.apiClient.sendRequest(url: url, method: "GET", body: nil, forResource: forResource){ (result) in
            switch result {
            case .success(let value):
                XCTFail("Expected to be a failure but got a success with \(value)")
            case .failure(let resultError):
                XCTAssertEqual(resultError.localizedDescription, "Data was not retrieved from request")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    
}
