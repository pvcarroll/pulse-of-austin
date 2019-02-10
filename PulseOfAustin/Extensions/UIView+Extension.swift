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
    
    func addActivityIndicatorView(activityIndicatorView: UIActivityIndicatorView) {
        self.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(
            item: activityIndicatorView,
            attribute: NSLayoutConstraint.Attribute.centerX,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.centerX,
            multiplier: 1, constant: 0)
        self.addConstraint(horizontalConstraint)
        let verticalConstraint = NSLayoutConstraint(
            item: activityIndicatorView,
            attribute: NSLayoutConstraint.Attribute.centerY,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.centerY,
            multiplier: 1, constant: 0)
        self.addConstraint(verticalConstraint)
        activityIndicatorView.color = UIColor.goldenRod247_179_19
        activityIndicatorView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicatorView.layer.cornerRadius = 5
        activityIndicatorView.hidesWhenStopped = true
    }
}

@IBDesignable
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
