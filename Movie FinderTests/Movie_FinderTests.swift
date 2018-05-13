//
//  Movie_FinderTests.swift
//  Movie FinderTests
//
//  Created by sheen vempeny on 5/8/18.
//  Copyright © 2018 sheen vempeny. All rights reserved.
//

import XCTest
@testable import Movie_Finder

class Movie_FinderTests: XCTestCase {
    
    let fetcher:MovieListFetcher = MovieListFetcher()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSearchSettings(){
        
        let urlString = Settings.shared.searchUrl()
        let key = Settings.shared.searchKey()
        
        XCTAssert(urlString != nil)
        XCTAssert(key != nil)
    }
    
    func testBatmanSearch() {
        
        let expectation: XCTestExpectation = XCTestExpectation(description: "BatmanTestCase")
        self.fetcher.searchMovie(name: "Batman", pageNum: 1) { (result:PageResult?, status:Bool) in
            
            XCTAssert(result != nil)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
   
    
}
