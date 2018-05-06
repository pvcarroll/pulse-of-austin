//
//  WeighInResults.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 5/6/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class WeighInResults: UIView {
    
    @IBOutlet var yourInputWasSentView: UIView!
    @IBOutlet var yourInputWasSentLabel: UILabel!
    @IBOutlet var cardTitle: UILabel!
    @IBOutlet var response1Tallies: UIView!
    @IBOutlet var response1Label: UILabel!
    @IBOutlet var response2Tallies: UIView!
    @IBOutlet var response2Label: UILabel!
    @IBOutlet var response3Tallies: UIView!
    @IBOutlet var response3Label: UILabel!
    @IBOutlet var response4View: UIView!
    @IBOutlet var response4Tallies: UIView!
    @IBOutlet var response4Label: UILabel!
    @IBOutlet var readVoicesButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.yourInputWasSentLabel.font = UIFont.buttonFont
        self.yourInputWasSentLabel.textColor = UIColor.whiteText
        self.yourInputWasSentView.layer.cornerRadius = 5
        
        self.cardTitle.font = UIFont.cardTitle
        self.cardTitle.textColor = UIColor.customDarkText
        self.response1Tallies.backgroundColor = UIColor.infoCardBackground
        self.response2Tallies.backgroundColor = UIColor.infoCardBackground
        self.response3Tallies.backgroundColor = UIColor.infoCardBackground
        self.response4Tallies.backgroundColor = UIColor.infoCardBackground
        self.response1Tallies.addBottomShadow()
        self.response2Tallies.addBottomShadow()
        self.response3Tallies.addBottomShadow()
        self.response4Tallies.addBottomShadow()
        
        self.response1Label.font = UIFont.introCardBody
        self.response2Label.font = UIFont.introCardBody
        self.response3Label.font = UIFont.introCardBody
        self.response4Label.font = UIFont.introCardBody
        
        self.readVoicesButton.backgroundColor = UIColor.white
        self.readVoicesButton.setTitle("READ VOICES", for: .normal)
        self.readVoicesButton.titleLabel?.font = UIFont.buttonFont
        self.readVoicesButton.setTitleColor(UIColor.customYellow, for: .normal)
        self.readVoicesButton.layer.borderColor = UIColor.lightGray.cgColor
        self.readVoicesButton.layer.borderWidth = 0.5
        self.readVoicesButton.layer.cornerRadius = self.readVoicesButton.frame.height / 2
        
        self.readVoicesButton.addBottomShadow()
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in
            self.yourInputWasSentView.isHidden = true
        })
    }
}
