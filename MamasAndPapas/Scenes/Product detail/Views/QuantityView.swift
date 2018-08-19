//
//  QuantityView.swift
//  MamasAndPapas
//
//  Created by volkan biçer on 18.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import UIKit

protocol QuantityViewDelegate: class{
    func quantityView(_ quantityView: QuantityView, didChange quantity: Int)
}

class QuantityView: UIView{
    
    weak var delegate: QuantityViewDelegate?
    var upLimit = 10 {
        didSet{
            quantity = upLimit == 0 ? 0 : 1
        }
    }
    private(set) var quantity: Int = 1{
        didSet{
            if quantity == 0 {
                setDisabled()
            }
            quantityLabel.text = String(quantity)
            delegate?.quantityView(self, didChange: quantity)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        let stackView = UIStackView(arrangedSubviews: [decreaseButton, quantityLabel, increaseButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setDisabled(){
        backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        increaseButton.isEnabled = false
        decreaseButton.isEnabled = false
    }
    
    private lazy var increaseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(QuantityView.didTapIncrease), for: .touchUpInside)
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        return button
    }()
    
    private lazy var decreaseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(QuantityView.didTapDecrease), for: .touchUpInside)
        button.setTitle("-", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)

        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textAlignment = .center
        label.text = String(quantity)
        return label
    }()
    
    @objc private func didTapIncrease(){
        if quantity == upLimit {return}
        quantity += 1
    }
    
    @objc private func didTapDecrease(){
        if quantity <= 1 {return}
        quantity -= 1
    }
}
