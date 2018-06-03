//
//  BreakdownView.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/3/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class BreakdownView: UIView {
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.amountLabel.font = UIFont.cardTitle
        self.descriptionLabel.lineBreakMode = .byWordWrapping
    }
}
