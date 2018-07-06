//
//  HomeViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/9/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var landingScreenTitle: UILabel!
    @IBOutlet var homeDescriptionLabel: UILabel!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBAction func loginTapped(_ sender: Any) {
        let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "Login") as! Login
        self.present(vc, animated: true)
    }
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        let vc = UIStoryboard(name: "CreateAccount", bundle: nil).instantiateViewController(withIdentifier: "CreateAccount") as! CreateAccount
        self.present(vc, animated: true)
    }
    
    @IBAction func skipTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toExplore", sender: self)
    }
    
    @IBAction func onboardingTapped(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingWelcome") as! OnboardingWelcome
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
        let createAccountAttrs: [NSAttributedStringKey: Any] = [NSAttributedStringKey.foregroundColor: UIColor.darkGray67_62_54]
        let createAccountString: NSMutableAttributedString = NSMutableAttributedString(string: "Create Account", attributes: createAccountAttrs)
        createAccountString.addUnderline()
        createAccountButton.setAttributedTitle(createAccountString, for: .normal)
        skipButton.titleLabel?.font = UIFont.futuraBold13
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
