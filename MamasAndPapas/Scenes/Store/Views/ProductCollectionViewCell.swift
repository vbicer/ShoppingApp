//
//  ProductCollectionViewCell.swift
//  MamasAndPapas
//
//  Created by volkan biçer on 15.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell{
    var product: ProductViewModel?{
        didSet{
            clearUI()
            bindUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI(){
        backgroundColor = .white
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        layer.cornerRadius = 5.0
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, priceLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0.0
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    private func bindUI(){
        guard let product = product else { return }
        
        let imageUrl = URL(string: product.imageFullUrl)!
        imageView.kf.setImage(with: imageUrl)
        
        titleLabel.text = product.name
        priceLabel.text = product.priceString
        descriptionLabel.text = product.description
    }
    
    private func clearUI(){
        imageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
        descriptionLabel.text = nil
    }
    
    private lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.red.withAlphaComponent(0.7)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        return label
    }()
}
