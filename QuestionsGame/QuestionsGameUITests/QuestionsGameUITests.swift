//
//  QuestionsGameUITests.swift
//  QuestionsGame
//
//  Created by Juan Rojas on 12/07/23.
//

import XCTest

class BasePage {
    var app = XCUIApplication()
}

class LazyLoadPage: BasePage {
    lazy var descendants = app.descendants(matching: .any)
    lazy var scrowViews =  app.scrollViews.otherElements
    lazy var categoryListElements = scrowViews.scrollViews["CategoryListView"].otherElements

}

class QuestionsGameUITests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    override class func setUp() {
        let app = XCUIApplication()
        app.launchEnvironment = ["ISTESTING": "true"]
        app.launch()
    }

    func testIfElementsExist() throws {
        let lazyLoadPage = LazyLoadPage()
        let descendants = lazyLoadPage.descendants
        let scrollViews = lazyLoadPage.scrowViews
        let categoryListElements = lazyLoadPage.categoryListElements
        let actionButton = descendants["ActionButtonView"]

        XCTAssertEqual(descendants.scrollViews.count, 2)
        XCTAssertEqual(scrollViews.scrollViews.count, 1)
        XCTAssertTrue(descendants["TitleTextView"].exists)
        XCTAssertTrue(descendants["SubTitleTextView"].exists)
        XCTAssertTrue(scrollViews.scrollViews["CategoryListView"].exists)
        XCTAssertTrue(categoryListElements.staticTexts["Animals"].waitForExistence(timeout: 2))
        XCTAssertTrue(descendants["CurrentQuestionCard"].exists)
        XCTAssertTrue(actionButton.exists)
        XCTAssertEqual(actionButton.label, "Next Question")
    }
    
    func testButtonShouldBeEnabledIfCategoryIsSelected() throws {
        let lazyLoadPage = LazyLoadPage()
        let descendants = lazyLoadPage.descendants
        let categoryListElements = lazyLoadPage.categoryListElements
        let actionButton = descendants["ActionButtonView"]
        
        XCTAssertTrue(actionButton.exists)
        XCTAssertFalse(actionButton.isEnabled)
        
        let categoryStaticText = categoryListElements.staticTexts["Animals"]
        XCTAssertTrue(categoryStaticText.exists)
        categoryStaticText.tap()
        
        XCTAssertTrue(actionButton.isEnabled)
    }
    
    func testScoreIfAllWrongQuestions() throws {
        // TODO
    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                let app = XCUIApplication()
                app.launchEnvironment = ["ISTESTING": "true"]
                app.launch()
            }
        }
    }
}
