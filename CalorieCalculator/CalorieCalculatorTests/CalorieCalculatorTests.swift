//
//  CalorieCalculatorTests.swift
//  CalorieCalculatorTests
//
//  Created by Mehmet Jiyan Atalay on 28.07.2024.
//

import XCTest
import Combine
import Foundation
@testable import CalorieCalculator

final class CalorieCalculatorTests: XCTestCase {
    
    var viewModel: SearchViewModel!
    var mockWebService: MockWebService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        super.setUp()
        mockWebService = MockWebService()
        viewModel = SearchViewModel()
        viewModel.webservice = mockWebService
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockWebService = nil
        super.tearDown()
    }
    
    func testDownloadCaloriesSuccess() async throws {
        let query = "apple"
        let testItem = Item(name: "Apple", calories: 53.0, servingSizeG: 100, fatTotalG: 0.2, proteinG: 0.3, cholesterolMg: 0, carbohydratesTotalG: 14.1, sugarG: 10.3)
        mockWebService.result = CalorieModel(items: [testItem])
        
        await viewModel.downloadCalories(query: query)
        
        XCTAssertEqual(viewModel.calories.count, 1)
        XCTAssertEqual(viewModel.calories.first?.name, "Apple")
        XCTAssertEqual(viewModel.calories.first?.calories, 53.0)
    }
    
    func testDownloadCaloriesFailure() async throws {
        let query = "apple"
        let error = NSError(domain: "test", code: 1, userInfo: nil)
        mockWebService.error = error
        
        await viewModel.downloadCalories(query: query)
        
        XCTAssertTrue(viewModel.calories.isEmpty)
    }
    
    func testDebounceTextChanges() {
        let expectation = XCTestExpectation(description: "Debounced text changes")
        
        viewModel.$calories
            .dropFirst()
            .sink { items in
                XCTAssertEqual(items.count, 1)
                XCTAssertEqual(items.first?.name, "Apple")
                XCTAssertEqual(items.first?.calories, 53.0)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        let testItem = Item(name: "Apple", calories: 53.0, servingSizeG: 100, fatTotalG: 0.2, proteinG: 0.3, cholesterolMg: 0, carbohydratesTotalG: 14.1, sugarG: 10.3)
        mockWebService.result = CalorieModel(items: [testItem])

        viewModel.foodname = "Apple"

        wait(for: [expectation], timeout: 1.5)
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class MockWebService : WebService {
    var result: CalorieModel? = nil
    var error: Error? = nil
    
    override func downloadCalories(url: URLRequest) async throws -> CalorieModel? {
        if let error = error {
            throw error
        }
        return result
    }
}
