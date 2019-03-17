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
    @IBOutlet weak var readUpCell: UIView!
    @IBOutlet weak var readUpLabel: UILabel!
    @IBOutlet weak var readUpDateLabel: UILabel!
    @IBOutlet weak var mapCell: UIView!
    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var mapDateLabel: UILabel!
    @IBOutlet weak var viewpointsCell: UIView!
    @IBOutlet weak var viewpointsLabel: UILabel!
    @IBOutlet weak var viewpointsDateLabel: UILabel!
    @IBOutlet weak var milestonesCell: UIView!
    @IBOutlet weak var milestoneView: UIView!
    @IBOutlet weak var milestonesLabel: UILabel!
    @IBOutlet weak var milestonesDateLabel: UILabel!
    @IBOutlet weak var crestImage1: UIImageView!
    @IBOutlet weak var crestImage2: UIImageView!
    @IBOutlet weak var crestImage3: UIImageView!
    @IBOutlet weak var scopeLabel: UILabel!
    @IBOutlet weak var draftLabel: UILabel!
    @IBOutlet weak var actLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.infoCardBackground
        
        self.readUpCell.addBottomShadow()
        self.mapCell.addBottomShadow()
        self.viewpointsCell.addBottomShadow()
        
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
