//
//  CreateAccount.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/23/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class CreateAccount: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: rm test
        HttpRequests.test()
        
        self.dismissKeyboardOnMainViewTap()
        
        screenTitle.font = UIFont.screenTitle
        screenTitle.textColor = UIColor.customDarkText
        screenSubtitle.font = UIFont.futura16
        screenSubtitle.textColor = UIColor.customDarkText
        
        createAnAccountButton.titleLabel?.font = UIFont.futura13
        createAnAccountButton.setTitleColor(UIColor.whiteText, for: .normal)
        createAnAccountButton.layer.backgroundColor = UIColor.customYellow.cgColor
        createAnAccountButton.layer.cornerRadius = createAnAccountButton.frame.height / 2.0
        
        loginButton.setTitleColor(UIColor.customDarkText, for: .normal)
        
        let loginButtonAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.foregroundColor: UIColor.darkText67_62_54,
                                                                NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]
        let loginTitleString: NSAttributedString = NSAttributedString(string: "Log in", attributes: loginButtonAttributes)
        loginButton.setAttributedTitle(loginTitleString, for: .normal)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameField.setBottomBorder()
        emailField.setBottomBorder()
        addressField.setBottomBorder()
        zipCodeField.setBottomBorder()
        passwordField.setBottomBorder()
        confirmPasswordField.setBottomBorder()
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
