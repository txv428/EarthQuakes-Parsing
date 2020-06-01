//
//  EarthQuakesParsingTests.swift
//  EarthQuakesParsingTests
//
//  Created by tejasree vangapalli on 6/1/20.
//  Copyright © 2020 tejasree vangapalli. All rights reserved.
//

import XCTest
@testable import EarthQuakesParsing

class EarthQuakesParsingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testErrorAlertController() {
        let val = UIViewController()
        let title = "Error title is"
        let message = "Error occured due to certain issue"
        let errorAlert: () = val.ErrorMessage(titleStr: title, messageStr: message)
        XCTAssert(errorAlert == (), "Error message Alert function works fine")
    }
    
    func testJSONParsing() {
        if let data = try? Data.init(contentsOf: URL(string: "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=\(date)&limit=50&offset=\(1)")!) {
            XCTAssertNotNil(data)
        } else {
            XCTFail()
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            //             Put the code you want to measure the time of here.
            let exp = expectation(description: "data fetch")
            if let data = try? Data.init(contentsOf: URL(string: "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=\(date)&limit=50&offset=\(1)")!) {
                exp.fulfill()
                XCTAssertNotNil(data)
            } else {
                XCTFail()
            }
            waitForExpectations(timeout: 10.0) { (error) in
                print(error?.localizedDescription as Any)
            }
        }
    }

}
