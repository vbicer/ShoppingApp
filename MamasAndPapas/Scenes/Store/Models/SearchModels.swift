//
//  SearchModels.swift
//  MamasAndPapas
//
//  Created by volkan biçer on 19.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation

enum Search {
    struct Request: Encodable {
        let searchString: String
        let page: Int
        let hitsPerPage: Int
        let filters: String
    }
    
    struct Response: Codable {
        let hits: [Product]
    }
}
