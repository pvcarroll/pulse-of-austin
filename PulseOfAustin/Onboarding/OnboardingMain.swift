//
//  OnboardingMain.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/17/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class OnboardingMain: UIViewController {
    
    @IBOutlet weak var stepper1Background: UIView!
    @IBOutlet weak var stepper2Background: UIView!
    @IBOutlet weak var stepper3Background: UIView!
    @IBOutlet weak var stepper1Label: UILabel!
    @IBOutlet weak var stepper2Label: UILabel!
    @IBOutlet weak var stepper3Label: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slide1: OnboardingSlideInfo?
    var slide2: OnboardingSlideInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepper1Background.layer.cornerRadius = stepper1Background.frame.height / 2
        stepper2Background.layer.cornerRadius = stepper1Background.frame.height / 2
        stepper3Background.layer.cornerRadius = stepper1Background.frame.height / 2
        stepper1Label.textColor = UIColor.whiteText
        stepper2Label.textColor = UIColor.customYellow
        stepper3Label.textColor = UIColor.customYellow
        
        slide1 = UINib(nibName: "OnboardingSlideInfo", bundle: nil).instantiate(withOwner: self, options: nil).first as! OnboardingSlideInfo?
        slide1?.slideTitle.text = "Be in the know"
        slide1?.slideImage.image = #imageLiteral(resourceName: "onboardingImage1")
        slide1?.slideBody.text = "Learn about important decisions being made that affect how you live in Austin."
        slide2 = UINib(nibName: "OnboardingSlideInfo", bundle: nil).instantiate(withOwner: self, options: nil).first as! OnboardingSlideInfo?
        slide2?.slideTitle.text = "Weigh in"
        slide2?.slideImage.image = #imageLiteral(resourceName: "onboardingImage2")
        slide2?.slideBody.text = "Share your perspective on city initiatives and see what others have to say, too."
        
        scrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let slide1 = self.slide1 {
            slide1.frame = scrollView.bounds
            scrollView.addSubview(slide1)
        }
        
        if let slide2 = self.slide2  {
            slide2.frame = CGRect(x: scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(slide2)
        }
        scrollView.contentSize = CGSize(width: scrollView.frame.width * 2, height: scrollView.frame.height)
    }
}

extension OnboardingMain: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        self.pageControl.currentPage = page
        switch page {
        case 0:
            self.stepper1Label.textColor = UIColor.white
            self.stepper1Background.backgroundColor = UIColor.customYellow
            self.stepper2Label.textColor = UIColor.customYellow
            self.stepper2Background.backgroundColor = UIColor.white
            self.stepper3Label.textColor = UIColor.customYellow
            self.stepper3Background.backgroundColor = UIColor.white
        case 1:
            self.stepper1Label.textColor = UIColor.customYellow
            self.stepper1Background.backgroundColor = UIColor.white
            self.stepper2Label.textColor = UIColor.white
            self.stepper2Background.backgroundColor = UIColor.customYellow
            self.stepper3Label.textColor = UIColor.customYellow
            self.stepper3Background.backgroundColor = UIColor.white
        case 2:
            self.stepper1Label.textColor = UIColor.customYellow
            self.stepper1Background.backgroundColor = UIColor.white
            self.stepper2Label.textColor = UIColor.customYellow
            self.stepper2Background.backgroundColor = UIColor.white
            self.stepper3Label.textColor = UIColor.white
            self.stepper3Background.backgroundColor = UIColor.customYellow
        default:
            return
        }
    }
}
