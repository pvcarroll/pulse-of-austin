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
    @IBOutlet weak var titleSummaryView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var viewpoint1View: UIView!
    @IBOutlet weak var viewpoint1Label: UILabel!
    @IBOutlet weak var viewpoint1ResponderLabel: UILabel!
    @IBOutlet weak var viewpoint1DateLabel: UILabel!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var viewpoint2View: UIView!
    @IBOutlet weak var viewpoint2Label: UILabel!
    @IBOutlet weak var viewpoint2ResponderLabel: UILabel!
    @IBOutlet weak var viewpoint2DateLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundView.layer.cornerRadius = 3.0
        self.addBottomShadow()
        self.pageControl.addBottomShadow()
    }
}
