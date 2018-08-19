//
//  ProductApiTests.swift
//  MamasAndPapasTests
//
//  Created by volkan biçer on 19.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import XCTest
@testable import MamasAndPapas

class ProductApiTest: XCTestCase{
    
    var api = ProductApi()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testShouldLoadData(){
        let promise = expectation(description: "Should return items")
        
        let request = Search.Request(searchString: "boy", page: 1, hitsPerPage: 1, filters: "")
        api.search(request) { (items, err) in
            if let message = err {
                XCTFail(message)
            }else if items != nil {
                promise.fulfill()
            }else{
                XCTFail("Items are not loaded")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    func testShouldLoadProductBySku(){
        let promise = expectation(description: "Should return item by sku")
        var sku = String()
        
       
        let request = Search.Request(searchString: "boy", page: 1, hitsPerPage: 1, filters: "")
        api.search(request) { (items, err) in
            if let productId = items?.first?.productId {
                sku = String(productId)
            }
        }
        
        api.productDetail(by: sku) { (model, err) in
            if let err = err {
                XCTFail(err)
            }else if  model != nil {
                promise.fulfill()
            }else{
                XCTFail("Item not loaded")
            }
        }
        
        waitForExpectations(timeout: 8, handler: nil)
    }
    
    
}
