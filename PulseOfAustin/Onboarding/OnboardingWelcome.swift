//
//  OnboardingWelcome.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/17/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class OnboardingWelcome: UIViewController {
    
    @IBOutlet weak var welcomeTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var welcomeMessage: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBAction func continueTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "OnboardingWelcomeToOnboardingMain", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeTitle.text = "Welcome to The Pulse of Austin"
        welcomeTitle.font = UIFont.futuraBold26
        welcomeTitle.textColor = UIColor.customDarkerText
        
        welcomeMessage.text = "The Pulse is a place to learn about and weigh in on changes happening in our city."
        welcomeMessage.font = UIFont.futura20
        welcomeMessage.textColor = UIColor.darkGray74
        
        continueButton.setTitle("SEE HOW IT WORKS", for: .normal)
        continueButton.setTitleColor(UIColor.whiteText, for: .normal)
        continueButton.titleLabel?.font = UIFont.buttonFont
        continueButton.backgroundColor = UIColor.customYellow
        continueButton.layer.cornerRadius = continueButton.frame.height / 2
    }
}
