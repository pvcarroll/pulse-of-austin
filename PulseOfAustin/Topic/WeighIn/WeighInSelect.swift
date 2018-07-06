//
//  WeighInSelect.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/30/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class WeighInSelect: UIView {
    
    @IBOutlet var cardTitle: UILabel!
    @IBOutlet var answerButtonsStackView: UIStackView!
    @IBOutlet var answer1Button: UIButton!
    @IBOutlet var answer2Button: UIButton!
    @IBOutlet var answer3Button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cardTitle.text = "SELECT CHOICE"
        self.cardTitle.font = UIFont.cardTitle
        self.cardTitle.textColor = UIColor.darkGray74

        self.answer1Button.backgroundColor = UIColor.infoCardBackground
        self.answer2Button.backgroundColor = UIColor.infoCardBackground
        self.answer3Button.backgroundColor = UIColor.infoCardBackground
        self.answer1Button.titleLabel?.font = UIFont.buttonFont
        self.answer2Button.titleLabel?.font = UIFont.buttonFont
        self.answer3Button.titleLabel?.font = UIFont.buttonFont
        self.answer1Button.setTitleColor(UIColor.darkGray74, for: .normal)
        self.answer2Button.setTitleColor(UIColor.darkGray74, for: .normal)
        self.answer3Button.setTitleColor(UIColor.darkGray74, for: .normal)
        self.answer1Button.layer.cornerRadius = 5
        self.answer2Button.layer.cornerRadius = 5
        self.answer3Button.layer.cornerRadius = 5
    }
}
