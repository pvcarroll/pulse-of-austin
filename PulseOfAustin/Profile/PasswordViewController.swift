//
//  PasswordViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 9/23/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit
import FirebaseAuth

class PasswordViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var currentPasswordField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    var email: String?
    
    @IBAction func confirmTapped(_ sender: Any) {
        guard self.newPasswordField.text == self.confirmPasswordField.text else {
            self.presentAlertModal(title: "", message: "new field and verify field must match")
            return
        }
    }
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        guard let email = self.email else { return }
        AuthUtils.sendPasswordReset(email: email)
        self.presentAlertModal(title: "", message: "Reset password email sent")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.dismissKeyboardOnMainViewTap()
        self.confirmButton.addBottomShadow()
        let forgotPasswordAttributedTitle: NSMutableAttributedString = NSMutableAttributedString(string: "Forgot Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray67_62_54])
        forgotPasswordAttributedTitle.addUnderline()
        self.forgotPasswordButton.setAttributedTitle(forgotPasswordAttributedTitle, for: .normal)
        
        // Adjust scroll view when keyboard is visible
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            self.scrollView.contentInset = UIEdgeInsets.zero
        } else {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset
    }
}
