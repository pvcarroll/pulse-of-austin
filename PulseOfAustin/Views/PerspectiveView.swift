//
//  PerspectiveView.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/3/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class PerspectiveView: UIView {
    
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var perspective: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.source.font = UIFont.cardTitle
    }
}
