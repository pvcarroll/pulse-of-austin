//
//  UIView+Extension.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/14/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

extension UIView {
    
    func addBottomShadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
    }
    
    func addBottomShadow(shadowColor: UIColor, shadowRadius: CGFloat) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 0.5
    }
}
