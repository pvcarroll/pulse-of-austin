//
//  OnboardingLastSlide.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 7/5/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class OnboardingLastSlide: UIView {
    
    @IBOutlet weak var slideTitle: UILabel!
    @IBOutlet weak var slideMessage: UILabel!
    @IBOutlet weak var slideGetStarted: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var skipForNowButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        slideTitle.textColor = UIColor.darkGray74
        slideMessage.textColor = UIColor.darkGray67_62_54
        slideGetStarted.textColor = UIColor.darkGray74
        createAccountButton.layer.cornerRadius = createAccountButton.frame.height / 2
        logInButton.setTitleColor(UIColor.darkGray74, for: .normal)
        logInButton.layer.cornerRadius = logInButton.frame.height / 2
        logInButton.layer.borderColor = UIColor.darkGray74.cgColor
        logInButton.layer.borderWidth = 1.0
        skipForNowButton.setTitleColor(UIColor.darkGray74, for: .normal)
    }
}
