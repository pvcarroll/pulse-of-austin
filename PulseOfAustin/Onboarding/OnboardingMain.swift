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
    var slide3: OnboardingLastSlide?
    
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
        slide3 = UINib(nibName: "OnboardingLastSlide", bundle: nil).instantiate(withOwner: self, options: nil).first as! OnboardingLastSlide?
        slide3?.createAccountButton.addTarget(self, action: #selector(self.loadCreateAccount), for: .touchUpInside)
        slide3?.logInButton.addTarget(self, action: #selector(self.loadLogin), for: .touchUpInside)
        slide3?.skipForNowButton.addTarget(self, action: #selector(self.loadExplore), for: .touchUpInside)
        scrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let scrollViewWidth = scrollView.frame.width
        let scrollViewHeight = scrollView.frame.height
        if let slide1 = self.slide1 {
            slide1.frame = scrollView.bounds
            scrollView.addSubview(slide1)
        }
        if let slide2 = self.slide2  {
            slide2.frame = CGRect(x: scrollViewWidth, y: 0, width: scrollViewWidth, height: scrollViewHeight)
            scrollView.addSubview(slide2)
        }
        if let slide3 = self.slide3 {
            slide3.frame = CGRect(x: scrollViewWidth * 2, y: 0, width: scrollViewWidth, height: scrollViewHeight)
            scrollView.addSubview(slide3)
        }
        scrollView.contentSize = CGSize(width: scrollViewWidth * 3, height: scrollViewHeight)
    }
    
    //
    // MARK: transitions
    //
    @objc private func loadCreateAccount(sender: UIButton!) {
        let createAccountVC = UIStoryboard(name: "CreateAccount", bundle: nil).instantiateViewController(withIdentifier: "CreateAccount") as! CreateAccount
        self.present(createAccountVC, animated: true, completion: nil)
    }
    @objc private func loadLogin(sender: UIButton!) {
        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "Login") as! Login
        self.present(loginVC, animated: true, completion: nil)
    }
    @objc private func loadExplore(sender: UIButton!) {
        let exploreVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
        self.present(exploreVC, animated: true, completion: nil)
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
