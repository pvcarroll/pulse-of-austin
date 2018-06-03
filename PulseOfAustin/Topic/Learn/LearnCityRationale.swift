//
//  LearnCityRationale.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/3/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class LearnCityRationale: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var perspectivesStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title.font = UIFont.cardTitle
    }
}
