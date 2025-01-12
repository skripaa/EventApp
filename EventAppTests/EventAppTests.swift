//
//  EventAppTests.swift
//  EventAppTests
//
//  Created by Vova SKR on 09/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import XCTest
@testable import EventApp

class MockUserDefaults: UserDefaults {
    var testResult = false
    
    override func set(_ value: Any?, forKey defaultName: String) {
        if defaultName == "UserId" {
            testResult = true
        }
        
    
    }
    
   
    
    
}

class EventAppTests: XCTestCase {
    
    
    var controllerUnderTest: ProfileVC!
    var mockUserDefaults: MockUserDefaults!

    override func setUp() {
        controllerUnderTest = ProfileVC()
        mockUserDefaults = MockUserDefaults(suiteName: "testing")
        controllerUnderTest.defaults = mockUserDefaults
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        controllerUnderTest = nil
        mockUserDefaults = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUserTokenDeleteWhenSignOut() {
        //when
        XCTAssertEqual(mockUserDefaults.testResult, false, "testResult should be false before sendActions")
        controllerUnderTest.singOutButtonTap()
        //then
        XCTAssertEqual(mockUserDefaults.testResult, true, "testResult user default wasn't changed")

    }
    

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
