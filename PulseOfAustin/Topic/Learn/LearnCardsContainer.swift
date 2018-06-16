//
//  LearnCardsContainer.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/9/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class LearnCardsContainer: UIView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.scrollView.delegate = self
    }
}

extension LearnCardsContainer: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        // Make off-screen cards translucent
        for i in 0..<(scrollView.subviews.count - 1) {
            scrollView.subviews[i].alpha = ((i == currentPage) ? 1.0 : 0.5)
        }
    }
}
