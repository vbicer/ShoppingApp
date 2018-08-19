//
//  ProductDetailScrollView.swift
//  MamasAndPapas
//
//  Created by volkan biçer on 15.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import UIKit

class ProductDetailScrollView: UIScrollView{

    lazy var topView: ProductDetailTopView = {
        let topView = ProductDetailTopView(frame: .zero)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = backgroundColor
        return topView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(topView)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: topAnchor),
            topView.leftAnchor.constraint(equalTo: leftAnchor),
            topView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
//            topView.rightAnchor.constraint(equalTo: rightAnchor),
            topView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
