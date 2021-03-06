//
//  HomeViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/9/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet var landingScreenTitle: UILabel!
    @IBOutlet var homeDescriptionLabel: UILabel!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBAction func loginTapped(_ sender: Any) {
        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginVC.redirectToMainAfterLogin = true
        self.present(loginVC, animated: true, completion: nil)
    }
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        let vc = UIStoryboard(name: "CreateAccount", bundle: nil).instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func skipTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toExplore", sender: self)
    }
    
    @IBAction func onboardingTapped(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingWelcome") as! OnboardingWelcomeViewController
        self.present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.landingScreenTitle.textColor = UIColor.darkGray74
        self.landingScreenTitle.font = UIFont.screenTitle
        self.homeDescriptionLabel.textColor = UIColor.darkGray74
        self.logInButton.backgroundColor = UIColor.customYellow
        self.logInButton.setTitle("LOG IN", for: .normal)
        self.logInButton.titleLabel?.font = UIFont.futura13
        self.logInButton.setTitleColor(UIColor.whiteText, for: .normal)
        self.logInButton.layer.cornerRadius = (self.logInButton.frame.height / 2)
        newLabel.textColor = UIColor.darkGray67_62_54
        let createAccountAttrs: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.darkGray67_62_54]
        let createAccountString: NSMutableAttributedString = NSMutableAttributedString(string: "Create Account", attributes: createAccountAttrs)
        createAccountString.addUnderline()
        createAccountButton.setAttributedTitle(createAccountString, for: .normal)
        skipButton.titleLabel?.font = UIFont.futuraBold13
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "toExplore", sender: self)
        }
    }
}
