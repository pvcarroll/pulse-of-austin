//
//  TopicIntroViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/19/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class TopicIntroViewController: UIViewController {
        
    @IBOutlet var contentView: UIView!
    @IBOutlet var topicIntroScreenTitle: UILabel!
    @IBOutlet var infoCard: UIView!
    @IBOutlet var infoCardBackgroundImageWidth: NSLayoutConstraint!
    @IBOutlet var infoCardBackgroundImageHeight: NSLayoutConstraint!
    @IBOutlet var topicIntroCardTitle: UILabel!
    @IBOutlet var topicIntroBodyText: UITextView!
    @IBOutlet var topicIntroBodyTextHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topicIntroPrompt: UILabel!
    @IBOutlet var learnMoreButton: UIButton!
    @IBOutlet var bottomSheetHandleView: UIView!
    @IBOutlet var bottomSheetHandleViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var bottomSheetDragHandle: UIView!
    @IBOutlet var bottomSheetHandleLabel: UILabel!
    @IBOutlet var bottomSheetExpanded: UIView!
    @IBOutlet var bottomSheetExpandedTitle: UILabel!
    @IBOutlet var bottomSheetSeparator: UIView!
    @IBOutlet var bottomSheetBodyText: UILabel!
    
    var selectedTopicKey: Int?
    
    @IBAction func learnMoreTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toTopicInfo", sender: self)
    }
    
    //
    // MARK:- Lifecycle Methods
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topicInfoData = TopicData.topics[self.selectedTopicKey!]?.topicIntroData
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "Explore"
        self.navigationItem.titleView = UIView()
        
        self.contentView.backgroundColor = UIColor.infoCardBackground
        self.topicIntroScreenTitle.text = topicInfoData?.topicTitle
        self.topicIntroScreenTitle.font = UIFont.screenTitle
        self.topicIntroScreenTitle.textColor = UIColor.customDarkText
        self.topicIntroCardTitle.text = topicInfoData?.cardTitle
        self.topicIntroCardTitle.font = UIFont.cardTitle
        self.topicIntroCardTitle.textColor = UIColor.darkGray
        
        self.topicIntroBodyText.attributedText = TopicData.topics[self.selectedTopicKey!]?.topicIntroData.cardBodyText
        self.topicIntroBodyText.textColor = UIColor.customDarkText
        if self.view.frame.width <= 321.0 {
            self.topicIntroBodyTextHeightConstraint.constant = 118
        }
        
        self.topicIntroPrompt.text = topicInfoData?.promptText
        self.topicIntroPrompt.font = UIFont.cardTitle
        self.topicIntroPrompt.textColor = UIColor.customDarkText
        
        self.learnMoreButton.backgroundColor = UIColor.customYellow
        self.learnMoreButton.setTitle("LEARN MORE", for: .normal)
        self.learnMoreButton.titleLabel?.font = UIFont.buttonFont
        self.learnMoreButton.setTitleColor(UIColor.whiteText, for: .normal)
        self.learnMoreButton.layer.cornerRadius = (self.learnMoreButton.frame.height / 2)
        
        let bottomSheetTouchRecognizer = UITapGestureRecognizer(target: self, action: #selector(bottomSheetHandleTapped(recognizer:)))
        self.bottomSheetHandleView.addGestureRecognizer(bottomSheetTouchRecognizer)
        
        self.bottomSheetHandleView.backgroundColor = UIColor.basicsBarBlue
        self.bottomSheetDragHandle.backgroundColor = UIColor.whiteText
        self.bottomSheetHandleLabel.text = "THE BASICS"
        self.bottomSheetHandleLabel.font = UIFont.buttonFont
        self.bottomSheetHandleLabel.textColor = UIColor.whiteText
        
        self.bottomSheetExpanded.isHidden = true
        self.bottomSheetExpanded.backgroundColor = UIColor.whiteBackground
        self.bottomSheetExpandedTitle.text = "TRANSPORTATION IN AUSTIN"
        self.bottomSheetExpandedTitle.font = UIFont.cardTitle
        self.bottomSheetExpandedTitle.textColor = UIColor.customDarkText
        self.bottomSheetSeparator.backgroundColor = UIColor.infoCardBackground
        
        self.bottomSheetBodyText.attributedText = buildBottomSheetList()
        self.bottomSheetBodyText.font = UIFont.introCardBody
        self.bottomSheetBodyText.textColor = UIColor.customDarkText
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.infoCardBackgroundImageWidth.constant = self.infoCard.bounds.width * 0.3
        self.infoCardBackgroundImageHeight.constant = self.infoCard.bounds.height * 0.45
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.topicIntroBodyText.setContentOffset(CGPoint.zero, animated: false)
    }
    
    //
    // MARK:- Private Methods
    //
    
    // "The Basics"
    private func buildBottomSheetList() -> NSAttributedString {
        let listItems = [
            "\u{2022} Austin's public bus system is run by Cap Metro. There are 3,000 bus stops and 53 routes.\n\n",
            "\u{2022} Only 4% of Austinites ride the bus.\n\n",
            "\u{2022} Austin's traffic is the worst.\n\n",
            "\u{2022} The city has a bike share program run by B-cycle."
        ]
        let bottomSheetAttributedString = NSMutableAttributedString()
        // Add paragraph style to text for each bullet point to fix indentation
        for listItem in listItems {
            let attributedString = NSMutableAttributedString(string: listItem)
            let listTextParagraphStyle = bottomSheetParagraphStyle()
            attributedString.addAttributes([NSAttributedStringKey.paragraphStyle: listTextParagraphStyle], range: NSMakeRange(0, attributedString.length))
            bottomSheetAttributedString.append(attributedString)
        }
        return bottomSheetAttributedString
    }
    
    // Indents lines of text to match the first line
    private func bottomSheetParagraphStyle() -> NSParagraphStyle {
        let paragraphStyle: NSMutableParagraphStyle
        paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: NSDictionary() as! [NSTextTab.OptionKey : Any])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 15
        return paragraphStyle
    }
    
    //
    // MARK:- Gesture Handler
    //
    
    @objc func bottomSheetHandleTapped(recognizer: UITapGestureRecognizer) {
        if self.bottomSheetExpanded.isHidden {
            self.bottomSheetExpanded.isHidden = false
            self.bottomSheetHandleViewBottomConstraint.constant =  self.bottomSheetExpanded.frame.height
        } else {
            self.bottomSheetExpanded.isHidden = true
            self.bottomSheetHandleViewBottomConstraint.constant =  0
        }
    }
    
    //
    // MARK:- Prepare for Segue
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? TopicInfoViewController)?.selectedTopicKey = self.selectedTopicKey
    }
}
