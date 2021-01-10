//
//  testNameParsing.swift
//  OndeEstiveTests
//
//  Created by Lucas Menezes on 1/19/20.
//  Copyright © 2020 Lucas Menezes. All rights reserved.
//
@testable import OndeEstive
import XCTest
class testNameParsing: XCTestCase {

    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let devices = ["Luke's iPhone", "Jake's iPhone",
        "Linda's iPad", "Jane's iPad", "iPhone de Jonas", "iPad de Julia"]
        let answers = ["Luke","Jake","Linda","Jane","Jonas","Julia"]
        for i in 0 ..< devices.count {
            let parsed = parseDeviceName(deviceName: devices[i])
            XCTAssert(parsed == answers[i],"\(parsed)")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
