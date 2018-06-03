//
//  LearnOverview.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/2/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class LearnOverview: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bodyTextStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title.font = UIFont.cardTitle
    }
}
