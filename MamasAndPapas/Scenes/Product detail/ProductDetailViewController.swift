//
//  ProductDetailViewController.swift
//  MamasAndPapas
//
//  Created by volkan biçer on 15.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController{
    
    let productApi = ProductApi()
    var product: ProductViewModel{
        didSet{
            bindUI()
            createAttributeViews()
        }
    }
    
    lazy var scrollView: ProductDetailScrollView = {
        let scrollView = ProductDetailScrollView()
        scrollView.backgroundColor = view.backgroundColor
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .red
        return indicator
    }()
    
    init(_ product: ProductViewModel) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindUI()
        createAttributeViews()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 50),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        scrollView.topView.addToBagButton.addTarget(self, action: #selector(ProductDetailViewController.didTapAddToBag), for: .touchUpInside)
        scrollView.topView.quantityView.delegate = self
    }

    fileprivate func getProduct(by sku: String){
        loadingIndicator.startAnimating()
        productApi.productDetail(by: sku) { [weak self](item, err) in
            self?.loadingIndicator.stopAnimating()
            if let err = err {
                self?.showAlert(err)
            }
            guard let product = item else { return }
            self?.product = product
        }
    }

    @objc private func didTapAddToBag(){
        showToast(message: "Added to your bag")
    }

    private func bindUI(){
        scrollView.topView.imageView.kf.setImage(with: URL(string: product.imageFullUrl)!)
        scrollView.topView.titleLabel.text = product.name
        scrollView.topView.priceLabel.text = product.priceString
        scrollView.topView.descriptionLabel.text = product.description
        scrollView.topView.quantityView.upLimit = product.maxAvailableQuantity
        
        if scrollView.topView.quantityView.quantity == 0 {
            scrollView.topView.setAddToBagButtonToDisabledState()
        }
    }

    private func createAttributeViews(){
        // invalidate views
        scrollView.topView.attributeStackView.removeAllArrangedSubviews()
        
        guard let sizeAttributes = product.size else { return }
        let sizeAttributeView = scrollView.topView.createAttributeViews(with: sizeAttributes)
        sizeAttributeView.delegate = self
        
        guard let colorAttribute = product.color else { return }
        let colorAttributeView = scrollView.topView.createAttributeViews(with: colorAttribute)
        colorAttributeView.delegate = self
    }
}

extension ProductDetailViewController: QuantityViewDelegate{
    func quantityView(_ quantityView: QuantityView, didChange quantity: Int) {
        print("New quantity: \(quantity)")
    }
}

extension ProductDetailViewController: AttributeViewDelegate{
    func attributeView(_ attributeView: AttributeView, didChange option: ProductViewModel.Attributes.Options?, for attribute: ProductViewModel.Attributes?) {
        
        guard let sku = option?.skus.first else { return }
        getProduct(by: sku)
    }
}
