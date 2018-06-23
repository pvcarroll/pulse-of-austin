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
    @IBOutlet var exploreButton: UIButton!
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBAction func exploreTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toExplore", sender: self)
    }
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
    }
    
    @IBAction func onboardingTapped(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingWelcome") as! OnboardingWelcome
        self.present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.landingScreenTitle.textColor = UIColor.customDarkText
        self.landingScreenTitle.font = UIFont.screenTitle
        self.homeDescriptionLabel.textColor = UIColor.customDarkText
        self.exploreButton.backgroundColor = UIColor.customYellow
        self.exploreButton.setTitle("EXPLORE", for: .normal)
        self.exploreButton.titleLabel?.font = UIFont.buttonFont
        self.exploreButton.setTitleColor(UIColor.whiteText, for: .normal)
        self.exploreButton.layer.cornerRadius = (self.exploreButton.frame.height / 2)
        newLabel.font = UIFont.futura16
        newLabel.textColor = UIColor.homeCreateAccountText
        let createAccountAttrs: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: UIFont.futura16,
                                  NSAttributedStringKey.foregroundColor: UIColor.homeCreateAccountText,
                                  NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]
        let createAccountString: NSAttributedString = NSAttributedString(string: "Create Account", attributes: createAccountAttrs)
        createAccountButton.setAttributedTitle(createAccountString, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
