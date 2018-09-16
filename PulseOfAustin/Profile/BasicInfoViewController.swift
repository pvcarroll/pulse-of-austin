//
//  BasicInfoViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 9/13/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class BasicInfoViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.dismissKeyboardOnMainViewTap()
        
        // Adjust scroll view when keyboard is visible
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            self.scrollView.contentInset = UIEdgeInsets.zero
        } else {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset
    }

}
