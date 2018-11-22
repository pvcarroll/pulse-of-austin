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
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var userData: UserData?
    var originalAddress = ""
    var originalZipCode = ""
    var originalEmail = ""
    
    @IBAction func saveTapped(_ sender: Any) {
        if (self.addressField.text == originalAddress) &&
              (self.zipCodeField.text == originalZipCode) &&
              (self.emailField.text == originalEmail) {return}
        guard let userID = self.userData?.userID else {return}
        guard let newAddress = self.addressField.text else {return}
        guard let newZipCode = self.zipCodeField.text else {return}
        guard let newEmail = self.emailField.text else {return}
        if let dbRef = (UIApplication.shared.delegate as! AppDelegate).dbRef {
            
            dbRef.child(AppConstants.dbUsersPath).child(userID).updateChildValues([
                "address": newAddress,
                "zipCode": newZipCode,
                "email": newEmail
            ])
            // TODO: changes saved confirmation, navigate back
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.dismissKeyboardOnMainViewTap()
        
        // TODO: saved changes don't appear after navigating back and returning to BasicInfo screen
        
        // Set intial values
        if let userData = self.userData {
            self.addressField.text = userData.address
            self.zipCodeField.text = userData.zipCode
            self.emailField.text = userData.email
            self.originalAddress = userData.address
            self.originalZipCode = userData.zipCode
            self.originalEmail = userData.email
        }
        
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
    
    // MARK:- Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? PasswordViewController)?.email = self.userData?.email
    }
    

}
