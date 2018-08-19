//
//  ProductDetailTopView.swift
//  MamasAndPapas
//
//  Created by volkan biçer on 15.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import UIKit
import Kingfisher

class ProductDetailTopView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(attributeStackView)
        addSubview(quantityView)
        addSubview(addToBagButton)
        addSubview(descriptionLabel)
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            priceLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            attributeStackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            attributeStackView.widthAnchor.constraint(equalToConstant: 250),
            attributeStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            attributeStackView.heightAnchor.constraint(equalToConstant: 0),
            ])
        
        
        NSLayoutConstraint.activate([
            quantityView.topAnchor.constraint(equalTo: attributeStackView.bottomAnchor, constant: 20),
            quantityView.centerXAnchor.constraint(equalTo: centerXAnchor),
            quantityView.widthAnchor.constraint(equalToConstant: 100),
            quantityView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            addToBagButton.topAnchor.constraint(equalTo: quantityView.bottomAnchor, constant: 20),
            addToBagButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addToBagButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 150),
            addToBagButton.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: addToBagButton.bottomAnchor, constant: 20),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    
    func createAttributeViews(with attribute: ProductViewModel.Attributes) -> AttributeView{
        
        let attributeView = makeAttributeView(attribute)
        attributeStackView.addArrangedSubview(attributeView)
        
        if let heightConstraint = attributeStackView.constraints.first(where: {$0.firstAttribute == .height}){
            heightConstraint.constant += 40
        }
        return attributeView
    }
    
    private func makeAttributeView(_ attribute: ProductViewModel.Attributes?) -> AttributeView{
        let attributeView = AttributeView()
        attributeView.attributes = attribute
        attributeView.translatesAutoresizingMaskIntoConstraints = false
        return attributeView
    }
    
    func setAddToBagButtonToDisabledState(){
        addToBagButton.isEnabled = false
        addToBagButton.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
    }
    
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)

        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.red.withAlphaComponent(0.7)
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    lazy var quantityView: QuantityView = {
        let quantityView = QuantityView()
        quantityView.translatesAutoresizingMaskIntoConstraints = false
        return quantityView
    }()
    
    lazy var addToBagButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ADD TO BAG", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.red.withAlphaComponent(0.7)
        return button
    }()
    
    lazy var attributeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0.0
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
}



































