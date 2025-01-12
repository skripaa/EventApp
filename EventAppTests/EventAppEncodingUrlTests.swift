//
//  EventAppEncodingUrlTests.swift
//  EventAppTests
//
//  Created by Vova SKR on 10/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import XCTest
@testable import EventApp_1

class EventAppEncodingUrlTests: XCTestCase {
    
    var route: Router<NetworkEnvironment>!
    
    override func setUp() {
        route = Router<NetworkEnvironment>(session: URLSession.shared)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        route = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testEncodingUrlRequest() {
        
        let finalRequest = URLRequest(url: URL(string: "https://kudago.com/public-api/v1.4/events/?categories=theater")!)
        
        var urlRequest = URLRequest(url: URL(string: "https://kudago.com/public-api/v1.4/events/")!)
        
        let urlParametres = ["categories": "theater"]
        try! ParameterEncoding.urlEncoding.encode(urlRequest: &urlRequest, bodyParameters: nil, urlParameters: urlParametres)
        //then
        XCTAssertEqual(urlRequest, finalRequest, "testResult user default wasn't changed")
        
        
    }
    
    func testBuildUrlRequestInGetUserData() {
        
        let request = try! route.buildRequest(from: .firebaseDataBase(.getUserData))
        let expectedResult = URLRequest(url: URL(string: "https://eventsbd-7d841.firebaseio.com/\(UserDefaults.standard.returnUserId())/.json")!)
        //then
        XCTAssertEqual(request.url, expectedResult.url)
        
        
    }
    
    func testHttpMethodInRequestToKudaGoApi () {
        let method = "GET"
        let request = try! route.buildRequest(from: .kudaGoAPI(.events(categories: .all, page: 1)))
        XCTAssertEqual(request.httpMethod!, method)
    }
    
    
    func testHttpMethodInRequestToFirebaseAuth () {
        let method = "POST"
        let request = try! route.buildRequest(from: .fireBaseAuth(.signIn(email: "", password: "")))
        XCTAssertEqual(request.httpMethod!, method)
    }
    
    func testHttpMethodInRequestToFirebaseDB () {
        let method = "GET"
        let request = try! route.buildRequest(from: .firebaseDataBase(.getUserData))
        XCTAssertEqual(request.httpMethod!, method)
    }
}
