//
//  OnboardingMain.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/17/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class OnboardingMain: UIViewController {
    
    @IBOutlet weak var stepper1Background: UIView!
    @IBOutlet weak var stepper2Background: UIView!
    @IBOutlet weak var stepper3Background: UIView!
    @IBOutlet weak var stepper1Label: UILabel!
    @IBOutlet weak var stepper2Label: UILabel!
    @IBOutlet weak var stepper3Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepper1Background.layer.cornerRadius = stepper1Background.frame.height / 2
        stepper2Background.layer.cornerRadius = stepper1Background.frame.height / 2
        stepper3Background.layer.cornerRadius = stepper1Background.frame.height / 2
        
        stepper1Label.textColor = UIColor.whiteText
        stepper2Label.textColor = UIColor.customYellow
        stepper3Label.textColor = UIColor.customYellow
    }
}
