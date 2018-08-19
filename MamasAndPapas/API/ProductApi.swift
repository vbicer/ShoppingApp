//
//  ProductApi.swift
//  MamasAndPapas
//
//  Created by volkan biçer on 17.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation
import Moya



class ProductApi{
    
    let provider = MoyaProvider<ProductService>(plugins: [NetworkLoggerPlugin(verbose: false, cURL: true)])
    
    
    func search(_ data: Search.Request, completion: @escaping ([ProductViewModel]?, String?) -> ()){
        provider.request(ProductService.search(data: data)) { (result) in
            switch result{
            case .success(let response):                
                guard let data = try? response.map(Search.Response.self)else {
                    completion(nil, "Parsing error!")
                    return
                }
                completion(ProductViewModel.createList(from: data.hits), nil)
            case .failure(let err):
                print(err)
                completion(nil, "Error occured!")
            }
        }
    }
    
    func productDetail(by slug: String, completion: @escaping (ProductViewModel?, String?) -> ()){
        provider.request(ProductService.productDetail(bySlug: slug)) { (result) in
            switch result{
            case .success(let response):
                guard let product = try? response.map(Product.self)else {
                    completion(nil, "Parsing error!")
                    return
                }
                completion(ProductViewModel.create(from: product), nil)
                
            case .failure(let err):
                print(err)
                completion(nil, "Error occured!")
            }
        }
    }
    
}
