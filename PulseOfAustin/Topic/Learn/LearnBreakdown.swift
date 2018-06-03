//
//  LearnBreakdown.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/3/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class LearnBreakdown: UIView {
    
    @IBOutlet weak var breakdownTitle: UILabel!
    @IBOutlet weak var breakdownStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.breakdownTitle.font = UIFont.cardTitle
    }
}
