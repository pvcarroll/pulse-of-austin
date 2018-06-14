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
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.scrollView.delegate = self
    }
}

extension LearnCardsContainer: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x / scrollView.frame.width
        self.pageControl.currentPage = Int(currentPage)
    }
}
