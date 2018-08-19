//
//  StoreViewController+UICollectionViewDelegate.swift
//  MamasAndPapas
//
//  Created by volkan biçer on 15.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import UIKit

extension StoreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = ProductDetailViewController(products[indexPath.row])
        navigationController?.pushViewController(detail, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == products.count - 3 {
            getProducts()
        }
    }
}
