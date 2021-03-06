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
    @IBOutlet weak var nameBottomBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var emailBottomBorder: UIView!
    @IBOutlet weak var emailBottomBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var addressBottomBorder: UIView!
    @IBOutlet weak var addressBottomBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var zipcodeBottomBorder: UIView!
    @IBOutlet weak var zipCodeBottomBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var passwordBottomBorder: UIView!
    @IBOutlet weak var passwordBottomBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var confirmPasswordBottomBorder: UIView!
    @IBOutlet weak var confirmPasswordBottomBorderHeight: NSLayoutConstraint!
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
    
    var isIntervention = false
    private let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.toHome()
    }
    @IBAction func createAccount(_ sender: UIButton) {
        guard self.validateFields() else { return }
        guard let email = emailField.text, let password = passwordField.text else { return }
        activityIndicatorView.startAnimating()
        view.layer.backgroundColor = UIColor(white: 0, alpha: 0.1).cgColor
        self.createAnAccountButton.isEnabled = false
        // Create firebase auth user with email and password
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                let failedToCreateAccountAlert = UIAlertController(title: "Create Account Failed", message: error.localizedDescription, preferredStyle: .alert)
                failedToCreateAccountAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(failedToCreateAccountAlert, animated: true, completion: nil)
                self.createAnAccountButton.isEnabled = true
            } else {
                // Auth user created
                guard let uid = authResult?.user.uid else {
                    self.deleteAuthCurrentUser()
                    return
                }
                guard let name = self.nameField.text
                    , let address = self.addressField.text
                    , let zipCode = self.zipCodeField.text else { return }
                // Get city council district from address
                HTTPRequests.getCouncilDistrict(address: address, completion: { councilDistrict in
                    if councilDistrict == 0 {
                        let alert = UIAlertController(title: "",
                                                      message: "We can't find your city council district (1-10) in the city's records. Please enter it here: ",
                                                      preferredStyle: .alert)
                        alert.addTextField(configurationHandler: { (textField) in
                            textField.placeholder = "District"
                            textField.keyboardType = .numberPad
                        })
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                            if let district = Int(alert?.textFields![0].text ?? "0")
                                , (1...10).contains(district) {
                                self.saveUser(uid: uid, name: name, email: email, address: address, zipCode: zipCode, councilDistrict: district)
                            } else {
                                self.presentAlertModal(title: "", message: "Austin city council districts are numbered 1-10")
                                self.deleteAuthCurrentUser()
                            }
                        }))
                        self.present(alert, animated: true)
                        self.createAnAccountButton.isEnabled = true
                        self.activityIndicatorView.stopAnimating()
                    } else {
                        self.saveUser(uid: uid, name: name, email: email, address: address, zipCode: zipCode, councilDistrict: councilDistrict)
                    }
                })
            }
        }
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        self.present(loginVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dismissKeyboardOnMainViewTap()
        
        nameField.delegate = self
        emailField.delegate = self
        addressField.delegate = self
        zipCodeField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        
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
        
        let loginButtonAttributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.foregroundColor: UIColor.darkGray67_62_54,
             NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let loginTitleString: NSAttributedString = NSAttributedString(string: "Log in", attributes: loginButtonAttributes)
        loginButton.setAttributedTitle(loginTitleString, for: .normal)

        view.addActivityIndicatorView(activityIndicatorView: activityIndicatorView)

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        activityIndicatorView.stopAnimating()
        super.viewWillDisappear(animated)
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
    
    //
    // MARK:- Private
    //
    
    private func validateFields() -> Bool {
        guard let name = self.nameField.text, !name.isEmpty else {
            self.displayValidationAlert(title: "Name is required", message: "")
            return false
        }
        guard let email = self.emailField.text, !email.isEmpty else {
            self.displayValidationAlert(title: "Email is required", message: "")
            return false
        }
        guard self.isValidEmail(email: email) else {
            self.displayValidationAlert(title: "Invalid email", message: "")
            return false
        }
        guard let address = self.addressField.text, !address.isEmpty else {
            self.displayValidationAlert(title: "Address is required", message: "")
            return false
        }
        guard let zipCode = self.zipCodeField.text, !zipCode.isEmpty else {
            self.displayValidationAlert(title: "Zip Code is required", message: "")
            return false
        }
        guard let password = self.passwordField.text, !password.isEmpty else {
            self.displayValidationAlert(title: "Password is required", message: "")
            return false
        }
        guard passwordField.text == confirmPasswordField.text else {
            self.displayValidationAlert(title: "", message: "Password and confirm password don't match.")
            return false
        }
        return true
    }
    private func isValidEmail(email:String?) -> Bool {
        guard email != nil else { return false }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    private func displayValidationAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    private func displaySuccessAlertAndGoToMainScreen() {
        let accountCreatedAlert = UIAlertController(title: "Account Created", message: "", preferredStyle: .alert)
        let continueAction = UIAlertAction(title: "Continue", style: .default) { _ in
            if self.isIntervention {
                self.dismiss(animated: true, completion: nil)
            } else {
                let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
                self.present(mainVC, animated: true, completion: nil)
            }
        }
        accountCreatedAlert.addAction(continueAction)
        self.present(accountCreatedAlert, animated: true)
    }
    
    // Auth user needs to be cleaned up in database user creation fails
    private func deleteAuthCurrentUser() {
        Auth.auth().currentUser?.delete(completion: { error in
            if error != nil {
                // Error deleting account
                self.presentAlertModal(title: "Error Deleting Auth User", message: error?.localizedDescription ?? "")
            } else {
                // Auth user deleted
            }
        })
    }
    
    private func saveUser(uid: String, name: String, email: String, address: String, zipCode: String, councilDistrict: Int) {
        let userData = [AppConstants.name: name,
                        AppConstants.email: email,
                        AppConstants.address: address,
                        AppConstants.zipCode: zipCode,
                        AppConstants.councilDistrict: councilDistrict] as [String : Any]
        HTTPRequests.saveNewUser(uid: uid, userData: userData) {
            self.displaySuccessAlertAndGoToMainScreen()
        }
    }
}

extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.nameField:
            self.emailField.becomeFirstResponder()
        case self.emailField:
            self.addressField.becomeFirstResponder()
        case self.addressField:
            self.zipCodeField.becomeFirstResponder()
        case self.zipCodeField:
            self.passwordField.becomeFirstResponder()
        case self.passwordField:
            self.confirmPasswordField.becomeFirstResponder()
        default:
            self.dismissKeyboard()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case self.nameField:
            self.nameBottomBorderHeight.constant = 2.0
        case self.emailField:
            self.emailBottomBorderHeight.constant = 2.0
        case self.addressField:
            self.addressBottomBorderHeight.constant = 2.0
        case self.zipCodeField:
            self.zipCodeBottomBorderHeight.constant = 2.0
        case self.passwordField:
            self.passwordBottomBorderHeight.constant = 2.0
        case self.confirmPasswordField:
            self.confirmPasswordBottomBorderHeight.constant = 2.0
        default:
            return
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.nameField:
            self.nameBottomBorderHeight.constant = 1.0
        case self.emailField:
            self.emailBottomBorderHeight.constant = 1.0
        case self.addressField:
            self.addressBottomBorderHeight.constant = 1.0
        case self.zipCodeField:
            self.zipCodeBottomBorderHeight.constant = 1.0
        case self.passwordField:
            self.passwordBottomBorderHeight.constant = 1.0
        case self.confirmPasswordField:
            self.confirmPasswordBottomBorderHeight.constant = 1.0
        default:
            return
        }
    }
}
