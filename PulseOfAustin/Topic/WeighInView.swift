//
//  WeighInView.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/30/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class WeighInView: UIView {
    
    @IBOutlet var cardTitle: UILabel!
    @IBOutlet var answerButtonsStackView: UIStackView!
    @IBOutlet var answer1Button: UIButton!
    @IBOutlet var answer2Button: UIButton!
    @IBOutlet var answer3Button: UIButton!
    @IBOutlet var weighInTextView: UITextView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var skipButton: UIButton!
    
    override func awakeFromNib() {
        self.cardTitle.text = "SELECT CHOICE"
        self.cardTitle.font = UIFont.cardTitle
        self.cardTitle.textColor = UIColor.customDarkText

        self.answer1Button.backgroundColor = UIColor.infoCardBackground
        self.answer2Button.backgroundColor = UIColor.infoCardBackground
        self.answer3Button.backgroundColor = UIColor.infoCardBackground
        self.answer1Button.setTitle("$300 Million Bond", for: .normal)
        self.answer2Button.setTitle("$161 Million Bond", for: .normal)
        self.answer3Button.setTitle("Other Thoughts", for: .normal)
        self.answer1Button.titleLabel?.font = UIFont.buttonFont
        self.answer2Button.titleLabel?.font = UIFont.buttonFont
        self.answer3Button.titleLabel?.font = UIFont.buttonFont
        self.answer1Button.setTitleColor(UIColor.customDarkText, for: .normal)
        self.answer2Button.setTitleColor(UIColor.customDarkText, for: .normal)
        self.answer3Button.setTitleColor(UIColor.customDarkText, for: .normal)
        self.answer1Button.layer.cornerRadius = 5
        self.answer2Button.layer.cornerRadius = 5
        self.answer3Button.layer.cornerRadius = 5
    }
}
