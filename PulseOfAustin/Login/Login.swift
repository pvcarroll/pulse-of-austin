//
//  Login.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 7/1/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit
import Firebase

class Login: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailUnderbar: UIView!
    @IBOutlet weak var passwordUnderbar: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBAction func login(_ sender: UIButton) {
        guard let email = emailField.text, let password = passwordField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                let loginFailedAlert = UIAlertController(title: "Login Failed", message: error.localizedDescription, preferredStyle: .alert)
                loginFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(loginFailedAlert, animated: true, completion: nil)
            } else {
                // Login successful, transition to Main VC
                let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
                self.present(mainVC, animated: true, completion: nil)
            }
        }
    }
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
    }
    @IBAction func createAccountTapped(_ sender: UIButton) {
        let createAccountVC = UIStoryboard(name: "CreateAccount", bundle: nil).instantiateViewController(withIdentifier: "CreateAccount") as! CreateAccount
        self.present(createAccountVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardOnMainViewTap()
        emailUnderbar.backgroundColor = UIColor.textFieldBottomBorder
        passwordUnderbar.backgroundColor = UIColor.textFieldBottomBorder
        loginButton.titleLabel?.font = UIFont.futura13
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.backgroundColor = UIColor.customYellow
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        let forgotPasswordAttributedTitle: NSMutableAttributedString = NSMutableAttributedString(string: "Forgot Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray67_62_54])
        forgotPasswordAttributedTitle.addUnderline()
        forgotPasswordButton.setAttributedTitle(forgotPasswordAttributedTitle, for: .normal)
        createAccountButton.setTitleColor(UIColor.darkGray67_62_54, for: .normal)
        
        // Register for keyboard notifications to adjust scroll view for keyboard
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    // Adjust scroll view content insets to make it scrollable when keyboard is visible
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
