//
//  APITests.swift
//  OndeEstiveTests
//
//  Created by Lucas Menezes on 1/19/20.
//  Copyright © 2020 Lucas Menezes. All rights reserved.
//


import XCTest
@testable import OndeEstive
class APITests: XCTestCase {

    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInsertCoordinate() {
       let api = API()
        let exp = XCTestExpectation()
        api.insertCoordinates(personId: 0, date: Date.init(timeIntervalSinceNow: 0), lat: 0.0, long: 0.17) { (isWorking) in
            XCTAssert(isWorking)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2)
        
    }
    func testInsertBulkCoordinate() {
       let api = API()
        let exp = XCTestExpectation()
        let dummyArray = [1.0,2.1,3.1,4.1,5.1]
        let array = dummyArray.map { (u) -> CoordinateParam in
            return CoordinateParam(personId: 0, date: Date.init(timeIntervalSinceNow: 0), lat: Float(u/100.0), long: Float(u/100.0))
        }
        print(array)
        
        api.insertBulkCoordinates(array: array) { (isWorking) in
            XCTAssert(isWorking)
                exp.fulfill()
        }
        wait(for: [exp], timeout: 2)
        
    }
    func testInsertBulkCoordinate2() {
       let api = API()
        let exp = XCTestExpectation()
        let dummyArray = [1.0,2.1,3.1,4.1,5.1]
        let array = dummyArray.map { (u) -> CoordinateParam in
            return CoordinateParam(personId: 0, date: Date.init(timeIntervalSinceNow: 0), lat: Float(u/100.0), long: Float(u/100.0))
        }
        print(array)
        
        api.insertBulkCoordinates2(array: array) { (isWorking) in
            XCTAssert(isWorking)
                exp.fulfill()
        }
        wait(for: [exp], timeout: 2)
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
