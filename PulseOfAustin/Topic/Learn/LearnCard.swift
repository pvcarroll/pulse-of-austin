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
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundView.layer.cornerRadius = 3.0
        self.addBottomShadow()
        self.pageControl.addBottomShadow()
    }
}
