//
//  LearnCard.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/9/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit
import WebKit

class LearnCard: UIView {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textView.layer.cornerRadius = 3.0
        self.addBottomShadow()
        self.pageControl.addBottomShadow()
    }
}
