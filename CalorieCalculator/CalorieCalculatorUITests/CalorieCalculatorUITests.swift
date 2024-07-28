//
//  CalorieCalculatorUITests.swift
//  CalorieCalculatorUITests
//
//  Created by Mehmet Jiyan Atalay on 28.07.2024.
//

import XCTest
@testable import CalorieCalculator

final class CalorieCalculatorUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()

        
        let tabbar = app.tabBars["Tab Bar"]
        let search = tabbar.buttons["Search"]
        search.tap()
        
                
        let searchField = app.textFields["Food name"]
        XCTAssertTrue(searchField.exists)
        searchField.tap()
        searchField.typeText("apple")
        
        let searchResult = app.collectionViews/*@START_MENU_TOKEN@*/.cells.buttons["apple, 53.00 cal"].staticTexts["apple"]/*[[".cells",".buttons[\"apple, 53.00 cal\"].staticTexts[\"apple\"]",".staticTexts[\"apple\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[2,1]]@END_MENU_TOKEN@*/
        
        XCTAssertTrue(searchResult.waitForExistence(timeout: 5))
        
        XCTAssertTrue(searchResult.exists)
                
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
