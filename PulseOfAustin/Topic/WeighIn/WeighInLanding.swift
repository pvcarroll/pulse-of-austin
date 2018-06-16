//
//  WeighInLanding.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/16/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class WeighInLanding: UIScrollView {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var one: UIView!
    @IBOutlet weak var two: UIView!
    @IBOutlet weak var three: UIView!
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var threeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.one.addBottomShadow()
        self.two.addBottomShadow()
        self.three.addBottomShadow()
        
        self.oneLabel.font = UIFont.introCardBodyBold
        self.twoLabel.font = UIFont.introCardBodyBold
        self.threeLabel.font = UIFont.introCardBodyBold
    }
}
