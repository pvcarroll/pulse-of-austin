//
//  CreateAccount.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/23/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit
import Firebase

class CreateAccount: UIViewController {
    
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
        // TODO: validate info - passwords fields match, 8 characters, required fields
        
        guard passwordField.text == confirmPasswordField.text else {
            let alert = UIAlertController(title: "YE SUCK", message: "Password and confirm password don't match.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        guard let email = emailField.text, let password = passwordField.text else { return }
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            print("CREATE USER")
            print("authResult = \(authResult)")
            print("error = \(error)")
            // TODO: Transition to different screen - Onboarding?
        }
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
}
