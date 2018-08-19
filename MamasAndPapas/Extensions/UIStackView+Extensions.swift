//
//  UIStackView+Extensions.swift
//  MamasAndPapas
//
//  Created by volkan biçer on 19.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
        
        if let heightConstraint = constraints.first(where: {$0.firstAttribute == .height }) {
            heightConstraint.constant = 0
        }
    }
}
