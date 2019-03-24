//
//  PerspectivesCard.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 3/23/19.
//  Copyright © 2019 Paul Carroll. All rights reserved.
//

import UIKit

class PerspectivesCard: UIView {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundView.layer.cornerRadius = 3.0
        self.addBottomShadow()
        self.pageControl.addBottomShadow()
    }
}
