//
//  ProductPagination.swift
//  MamasAndPapas
//
//  Created by volkan biçer on 15.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation

struct Paginator {
    private(set)var itemCount: Int = 10
    var currentPage: Int = 1
    var lastItemCount: Int = 0{
        willSet{
            isStarted = true
        }
    }
    private(set) var isStarted: Bool = false
    
    
    init(itemCount: Int = 10) {
        self.itemCount = itemCount
    }
    
    var noMorePagination: Bool {
        if isStarted && lastItemCount < itemCount {
            return true
        }
        return false
    }
    
    mutating func next(loaded itemCount: Int){
        currentPage += 1
        lastItemCount = itemCount
    }
    
    mutating func reset(){
        currentPage = 1        
    }
    
    
}
