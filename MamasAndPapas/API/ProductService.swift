//
//  ProductService.swift
//  MamasAndPapas
//
//  Created by volkan biçer on 17.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation
import Moya

enum ProductService{
    case search(data: Search.Request)
    case productDetail(bySlug: String)
}


extension ProductService: TargetType{
    var baseURL: URL {
        return URL(string: ApiConstants.BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search/full"
        case .productDetail:
            return "/product/findbyslug"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .post
        case .productDetail:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .search(let data):
            return Task.requestParameters(parameters: data.dictionary, encoding: URLEncoding.queryString)
        case .productDetail(let slug):
            return Task.requestParameters(parameters: ["slug":slug], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    
}

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
