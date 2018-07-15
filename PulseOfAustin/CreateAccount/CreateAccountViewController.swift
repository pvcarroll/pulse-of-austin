//
//  CreateAccount.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/23/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var nameBottomBorder: UIView!
    @IBOutlet weak var emailBottomBorder: UIView!
    @IBOutlet weak var addressBottomBorder: UIView!
    @IBOutlet weak var zipcodeBottomBorder: UIView!
    @IBOutlet weak var passwordBottomBorder: UIView!
    @IBOutlet weak var confirmPasswordBottomBorder: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var screenSubtitle: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var createAnAccountButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func createAccount(_ sender: UIButton) {
        // TODO: validate fields - passwords fields match, 8 characters, required fields
        
        guard passwordField.text == confirmPasswordField.text else {
            let alert = UIAlertController(title: "YE SUCK", message: "Password and confirm password don't match.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        guard let email = emailField.text, let password = passwordField.text else { return }
        // Create firebase auth user with email and password
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                let failedToCreateAccountAlert = UIAlertController(title: "Create Account Failed", message: error.localizedDescription, preferredStyle: .alert)
                failedToCreateAccountAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            } else {
                // Create user in database with all fields
                if let dbRef = (UIApplication.shared.delegate as! AppDelegate).dbRef {
                    guard let name = self.nameField.text,
                          let address = self.addressField.text,
                          let zipCode = self.zipCodeField.text else { return }
                    let userData = ["name": name, "email": email, "address": address, "zipCode": zipCode]
                    dbRef.child("users").childByAutoId().setValue(userData)
                    
                    self.presentSuccessAlertAndGoToMainScreen()
                }
            }
        }
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "Login")
        self.present(loginVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: rm test
        HttpRequests.test()
        
        self.dismissKeyboardOnMainViewTap()
        
        nameBottomBorder.backgroundColor = UIColor.textFieldBottomBorder
        emailBottomBorder.backgroundColor = UIColor.textFieldBottomBorder
        addressBottomBorder.backgroundColor = UIColor.textFieldBottomBorder
        zipcodeBottomBorder.backgroundColor = UIColor.textFieldBottomBorder
        passwordBottomBorder.backgroundColor = UIColor.textFieldBottomBorder
        confirmPasswordBottomBorder.backgroundColor = UIColor.textFieldBottomBorder
        
        screenTitle.font = UIFont.screenTitle
        screenTitle.textColor = UIColor.darkGray74
        screenSubtitle.font = UIFont.futura16
        screenSubtitle.textColor = UIColor.darkGray74
        
        createAnAccountButton.titleLabel?.font = UIFont.futura13
        createAnAccountButton.setTitleColor(UIColor.whiteText, for: .normal)
        createAnAccountButton.layer.backgroundColor = UIColor.customYellow.cgColor
        createAnAccountButton.layer.cornerRadius = createAnAccountButton.frame.height / 2.0
        
        loginButton.setTitleColor(UIColor.darkGray74, for: .normal)
        
        let loginButtonAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.foregroundColor: UIColor.darkGray67_62_54,
                                                                NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]
        let loginTitleString: NSAttributedString = NSAttributedString(string: "Log in", attributes: loginButtonAttributes)
        loginButton.setAttributedTitle(loginTitleString, for: .normal)
        
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
    
    //
    // MARK:- Private
    //
    private func presentSuccessAlertAndGoToMainScreen() {
        let accountCreatedAlert = UIAlertController(title: "Account Created", message: "", preferredStyle: .alert)
        let continueAction = UIAlertAction(title: "Explore topics", style: .default) { _ in
            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
            self.present(mainVC, animated: true, completion: nil)
        }
        accountCreatedAlert.addAction(continueAction)
        self.present(accountCreatedAlert, animated: true)
    }
}
