//
//  UITextField+Extension.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/24/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

extension UITextField {
    func setBottomBorder() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.textFieldBottomBorder.cgColor
        border.frame = CGRect(x: 0,
                              y: self.frame.size.height - width,
                              width: self.frame.size.width,
                              height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
