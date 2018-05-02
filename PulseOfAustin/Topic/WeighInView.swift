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
    @IBOutlet var answersButtonsStackView: UIStackView!
    @IBOutlet var weighInTextView: UITextView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var skipButton: UIButton!
    
    override func awakeFromNib() {
        self.cardTitle.text = "SELECT CHOICE"
        // font and color
        
    }
}
