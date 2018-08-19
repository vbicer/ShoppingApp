//
//  Product.swift
//  MamasAndPapas
//
//  Created by volkan biçer on 17.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation


import Foundation

struct Product: Codable {
    let productID: Int
    let description: String?
    let price: Double
    let configurableAttributes: [ConfigurableAttribute]?
    let name: String
    let image: String
    let sizeCodeId: Int?
    let sizeCode: String?
    let color: String?
    let colorId: Int?
    let stock: Stock?

    
    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case name, description, price, configurableAttributes, image, sizeCodeId, sizeCode, stock, color, colorId
    }
}


struct ConfigurableAttribute: Codable {
    let code: String
    let options: [Option]
}

struct Option: Codable {
    let optionID: Int
    let label: String
    let simpleProductSkus: [String]
    let isInStock: Bool?
    
    enum CodingKeys: String, CodingKey {
        case optionID = "optionId"
        case label, simpleProductSkus, isInStock
    }
}

struct Stock: Codable {
    let homeDeliveryQty, clickAndCollectQty, maxAvailableQty: Int?
}

