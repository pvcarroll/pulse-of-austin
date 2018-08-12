//
//  LearnLanding.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/2/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class LearnLanding: UIScrollView {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var info: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var map: UIView!
    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var perspectives: UIView!
    @IBOutlet weak var perspectivesLabel: UILabel!
    @IBOutlet weak var milestoneView: UIView!
    @IBOutlet weak var milestonesLabel: UILabel!
    @IBOutlet weak var crestImage1: UIImageView!
    @IBOutlet weak var crestImage2: UIImageView!
    @IBOutlet weak var crestImage3: UIImageView!
    @IBOutlet weak var scopeLabel: UILabel!
    @IBOutlet weak var draftLabel: UILabel!
    @IBOutlet weak var actLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.infoCardBackground
        
        self.info.addBottomShadow()
        self.map.addBottomShadow()
        self.perspectives.addBottomShadow()
        
        self.perspectivesLabel.text = "PERSPECTIVES"
        self.infoLabel.font = UIFont.introCardBodyBold
        self.mapLabel.font = UIFont.introCardBodyBold
        self.perspectivesLabel.font = UIFont.introCardBodyBold
        self.milestonesLabel.font = UIFont.introCardBodyBold
        self.crestImage1.backgroundColor = UIColor.infoCardBackground
        self.crestImage2.backgroundColor = UIColor.infoCardBackground
        self.crestImage3.backgroundColor = UIColor.infoCardBackground
        let crestImageBackgroundCornerRadius = self.crestImage1.frame.height / 2
        self.crestImage1.layer.cornerRadius = crestImageBackgroundCornerRadius
        self.crestImage2.layer.cornerRadius = crestImageBackgroundCornerRadius
        self.crestImage3.layer.cornerRadius = crestImageBackgroundCornerRadius
        self.crestImage1.addBottomShadow(shadowColor: UIColor.black, shadowRadius: 4)
        self.crestImage2.addBottomShadow(shadowColor: UIColor.black, shadowRadius: 4)
        self.crestImage3.addBottomShadow(shadowColor: UIColor.black, shadowRadius: 4)
        
        self.scopeLabel.backgroundColor = UIColor.customYellow
        self.draftLabel.backgroundColor = UIColor.customYellow
        self.actLabel.backgroundColor = UIColor.customYellow
        let milestoneStageCornerRadius = self.scopeLabel.frame.height / 2
        self.scopeLabel.layer.cornerRadius = milestoneStageCornerRadius
        self.draftLabel.layer.cornerRadius = milestoneStageCornerRadius
        self.actLabel.layer.cornerRadius = milestoneStageCornerRadius
        self.scopeLabel.layer.masksToBounds = true
        self.draftLabel.layer.masksToBounds = true
        self.actLabel.layer.masksToBounds = true
        self.scopeLabel.textColor = UIColor.whiteText
        self.draftLabel.textColor = UIColor.whiteText
        self.actLabel.textColor = UIColor.whiteText
    }
}
