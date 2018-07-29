//
//  LoginViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 7/1/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailUnderbar: UIView!
    @IBOutlet weak var emailBottomBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var passwordUnderbar: UIView!
    @IBOutlet weak var passwordBottomBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    var isIntervention = false
    var fromLanding = false
    var completionHandler: (()->Void)? = nil
    
    @IBAction func login(_ sender: UIButton) {
        guard let email = emailField.text, let password = passwordField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                let loginFailedAlert = UIAlertController(title: "Login Failed", message: error.localizedDescription, preferredStyle: .alert)
                loginFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(loginFailedAlert, animated: true, completion: nil)
            } else if self.fromLanding {
                // Logging in from the landing screen redirects to main screen
                let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
                self.present(mainVC, animated: true, completion: nil)
            } else {
                // Login intervention continues in same flow
                self.dismiss(animated: true, completion: self.completionHandler ?? nil)
            }
        }
    }
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
    }
    @IBAction func createAccountTapped(_ sender: UIButton) {
        let createAccountVC = UIStoryboard(name: "CreateAccount", bundle: nil).instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
        createAccountVC.isIntervention = self.isIntervention
        self.present(createAccountVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardOnMainViewTap()
        emailField.delegate = self
        passwordField.delegate = self
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

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.emailField:
            self.passwordField.becomeFirstResponder()
        default:
            self.dismissKeyboard()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case self.emailField:
            self.emailBottomBorderHeight.constant = 1.5
        case self.passwordField:
            self.passwordBottomBorderHeight.constant = 1.5
        default:
            return
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.emailField:
            self.emailBottomBorderHeight.constant = 0.5
        case self.passwordField:
            self.passwordBottomBorderHeight.constant = 0.5
        default:
            return
        }
    }
}
