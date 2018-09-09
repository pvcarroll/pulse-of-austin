//
//  UIViewController+Extension.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 7/1/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func dismissKeyboardOnMainViewTap() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func presentAlertModal(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
