//
//  StoreModels.swift
//  MamasAndPapas
//
//  Created by volkan biçer on 15.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation

struct ProductViewModel {
    let productId: Int
    let name: String
    let imageUrl: String
    let description: String
    let price: Double
    let size: Attributes?
    let color: Attributes?
    let maxAvailableQuantity: Int
    var priceString: String{
        return String(format: "AED %.2f", arguments: [price])
    }
    
    var imageFullUrl: String{
        return "\(ApiConstants.CND_URL)\(imageUrl)"
    }
    
}

extension ProductViewModel{
    struct Attributes {
        let code: String
        let options: [Options]
    }
}

extension ProductViewModel.Attributes{
    struct Options {
        let id: Int
        let label: String
        let isInStock: Bool
        let skus: [String]
        let isSelected: Bool
    }
}


extension ProductViewModel {

    fileprivate static func getAttribute(_ product: Product, for type: AttributeType) -> ProductViewModel.Attributes? {
        var attribute: Attributes?

        if let configurableAttributes = product.configurableAttributes {
            if let attr = configurableAttributes.first(where: {$0.code == type.code}){
                let options = attr.options.map { op -> ProductViewModel.Attributes.Options in
                    
                    var isSelected = false
                    
                    switch type {
                    case .size:
                        isSelected = product.sizeCodeId == op.optionID
                    case .color:
                        isSelected = product.colorId == op.optionID
                    }
                    
                    return Attributes.Options(id: op.optionID,
                                              label: op.label,
                                              isInStock: op.isInStock ?? false,
                                              skus: op.simpleProductSkus,
                                              isSelected: isSelected)
                }
                 attribute = Attributes(code: attr.code, options: options)
            }
        }
        
        return attribute
    }
    
    static func create(from product: Product) -> ProductViewModel{
        
        let sizeAttribute = getAttribute(product, for: .size)
        let colorAttribute = getAttribute(product, for: .color)
        let model = ProductViewModel(productId: product.productID,
                                     name: product.name,
                                     imageUrl: product.image,
                                     description: product.description?.htmlToString ?? "",
                                     price: product.price,
                                     size: sizeAttribute,
                                     color: colorAttribute,
                                     maxAvailableQuantity: product.stock?.maxAvailableQty ?? 0)
        return model
    }
    
    static func createList(from productList: [Product]) -> [ProductViewModel]{
        return productList.map { return create(from: $0)}
    }
}

enum AttributeType{
    case size, color
    
    var code: String {
        switch self {
        case .size:
            return "sizeCode"
        case .color:
            return "color"
        }
    }
}


