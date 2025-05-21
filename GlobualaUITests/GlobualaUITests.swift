//
//  GlobualaUITests.swift
//  GlobualaUITests
//
//  Created by Joni Gonzalez on 16/05/2025.
//

import XCTest

final class GlobualaUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    @MainActor
    func testCitiesView() throws {
        // Launch the app
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.navigationBars["Ciudades"].exists, "Title exist")
        
        let timeout = 5.0
        let citiesList = app.collectionViews.firstMatch
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == true"),
            object: citiesList
        )
        
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        XCTAssertEqual(result, .completed, "appear within \(timeout) seconds")
        
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists, "Search field should exist")
        searchField.tap()
        searchField.typeText("a")
        
        sleep(1)
        
        if citiesList.cells.count > 0 {
            let firstCity = citiesList.cells.element(boundBy: 0)
            firstCity.tap()
            
            // Verify map appears
            XCTAssertTrue(app.maps.firstMatch.exists, "Map should appear after selecting a city")
            
            // Test favorite functionality
            let favoriteButton = firstCity.buttons.matching(
                NSPredicate(format: "label CONTAINS 'favorite'")
            ).firstMatch
            
            if favoriteButton.exists {
                favoriteButton.tap()
                // Verify the button state changed (this would depend on your implementation)
            }
        }
    }
}
