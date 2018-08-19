//
//  PaginatorTests.swift
//  MamasAndPapasTests
//
//  Created by volkan biçer on 19.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import XCTest
@testable import MamasAndPapas

class PaginatorTests: XCTestCase{
    
    var paginator: Paginator!
    
    override func setUp() {
        super.setUp()
        paginator = Paginator()
    }
    
    override func tearDown() {
        paginator = nil
        super.tearDown()
    }
    
    func testPagintorShoudStartTheCurrentPageWithOne(){
        XCTAssertEqual(paginator.currentPage, 1, "Paginator not started from 1!")
    }
    
    func testPaginatorShouldNext(){
        let guess = 3
        
        paginator.next(loaded: paginator.itemCount)
        paginator.next(loaded: paginator.itemCount)
        
        XCTAssertEqual(paginator.currentPage, guess, "Paginator current page value wrong!")
    }
    
    func testPaginatorShouldReset(){
        for _ in 0...5 {
            paginator.next(loaded: paginator.itemCount)
        }
        
        paginator.reset()
        
        XCTAssertEqual(paginator.currentPage, 1, "Paginator reset didn't wok!")
    }
    
    func testPaginatorShoudReturnNoMorePaginationIfLastItemsCountSmallerThanItemCount(){
        paginator = Paginator(itemCount: 10)
        paginator.next(loaded: 5)
        
        XCTAssertTrue(paginator.noMorePagination, "Paginator no more pagination not working!")
    }
    
    func testPaginatorNoMorePaginationShouldFalseWhenPaginatorInitiated(){
        XCTAssertFalse(paginator.noMorePagination, "Paginator no more pagination not working!")
    }
    
}
