//
//  ViewController.swift
//  MamasAndPapas
//
//  Created by volkan biçer on 15.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {

    lazy var collectionView: UICollectionView = makeCollectionView()
    lazy var refreshControl: UIRefreshControl = makeRefreshControl()
    var isLoading = false
    let category = "boy"
    private let productApi = ProductApi()
    var paginator = Paginator(itemCount: 15)
    var products = [ProductViewModel](){
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Store"
        setupUI()
        setBackground()
        refreshProducts()
    }
    
    private func setupUI(){
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 50),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func getProducts(){
        if isLoading || paginator.noMorePagination { return }
        isLoading = true
        let request = Search.Request(searchString: category,
                                     page: paginator.currentPage,
                                     hitsPerPage: paginator.itemCount,
                                     filters: "")
        productApi.search(request) { [weak self](items, err) in
            self?.isLoading = false
            if let msg = err {
                self?.showAlert(msg)
                return
            }
            guard let items = items else { return }
            self?.products += items
            self?.paginator.next(loaded: items.count)
            
        }
    }
    
    func refreshProducts(){
        if isLoading { return }
        isLoading = true
        self.paginator.reset()
        let request = Search.Request(searchString: category,
                                     page: paginator.currentPage,
                                     hitsPerPage: paginator.itemCount,
                                     filters: "")
        productApi.search(request) { [weak self](items, err) in
            self?.loadingIndicator.stopAnimating()
            self?.isLoading = false
            if let msg = err {
                self?.showAlert(msg)
                return
            }
            guard let items = items else { return }
            self?.products = items
            self?.refreshControl.endRefreshing()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    private func makeCollectionView() -> UICollectionView{
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(ProductCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: ProductCollectionViewCell.self))
        collectionView.addSubview(refreshControl)
        self.view.addSubview(collectionView)
        return collectionView
    }
    
    
    private func makeRefreshControl() -> UIRefreshControl {
        let control = UIRefreshControl(frame: .zero)
        control.addTarget(self, action: #selector(StoreViewController.didRefresh), for: .valueChanged)
        control.tintColor = .red
        return control
    }
    
    
    @objc private func didRefresh(){
        refreshProducts()
    }

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .red
        indicator.startAnimating()
        return indicator
    }()
}






