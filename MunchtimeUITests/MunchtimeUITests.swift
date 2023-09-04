//
//  MunchtimeUITests.swift
//  MunchtimeUITests
//
//  Created by Robert Haworth on 8/31/23.
//

import XCTest
@testable import Munchtime

final class MunchtimeUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMealListTitle() throws {
        let navigationTitle = app.navigationBars.staticTexts["Munchtime Planner"]
        XCTAssert(navigationTitle.exists)
    }

    func testMealListStructuralLayout() throws {
        awaitLoad()

        let scrollView = app.scrollViews.firstMatch
        let gridView = app.otherElements["GridView"]

        /// Testing our general expected structure of our primary screen.
        XCTAssert(scrollView.exists)
        XCTAssert(gridView.exists)

        /// Affirm _some_ data has loaded.
        XCTAssertGreaterThan(app.buttons.count, 0)
    }

    func testMealListDetailNavigation() throws {
        awaitLoad()

        app.buttons.firstMatch.tap()

        awaitLoad()

        XCTAssertFalse(app.navigationBars.staticTexts["Munchtime Planner"].exists)

    }

    fileprivate func awaitLoad() {
        let exp = expectation(description: "Delaying to give view time to load data.")
        _ = XCTWaiter.wait(for: [exp], timeout: 1.5)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
