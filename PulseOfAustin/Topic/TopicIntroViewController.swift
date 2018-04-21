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
    @IBOutlet var topicIntroBodyText: UILabel!
    @IBOutlet var topicIntroPrompt: UILabel!
    @IBOutlet var learnMoreButton: UIButton!
    @IBOutlet var bottomSheetCollapsed: UIView!
    @IBOutlet var bottomSheetDragHandle: UIView!
    @IBOutlet var bottomSheetLabel: UILabel!
    
    @IBAction func learnMoreTapped(_ sender: Any) {
    }
    
    //
    // MARK: Lifecycle Methods
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.contentView.backgroundColor = UIColor.infoCardBackground
        self.topicIntroScreenTitle.text = "Dockless Bikeshare"
        self.topicIntroScreenTitle.font = UIFont.screenTitle
        self.topicIntroScreenTitle.textColor = UIColor.customDarkText
        self.topicIntroCardTitle.text = "PILOT KICKOFF"
        self.topicIntroCardTitle.font = UIFont.cardTitle
        self.topicIntroCardTitle.textColor = UIColor.darkGray
        
        self.topicIntroBodyText.attributedText = buildBodyText()
        self.topicIntroBodyText.textColor = UIColor.customDarkText
        
        self.topicIntroPrompt.text = "WHAT COULD THIS MEAN FOR RIDERSHIP DATA?"
        self.topicIntroPrompt.font = UIFont.cardTitle
        self.topicIntroPrompt.textColor = UIColor.customDarkText
        
        self.learnMoreButton.backgroundColor = UIColor.customYellow
        self.learnMoreButton.setTitle("LEARN MORE", for: .normal)
        self.learnMoreButton.titleLabel?.font = UIFont.buttonFont
        self.learnMoreButton.setTitleColor(UIColor.whiteText, for: .normal)
        self.learnMoreButton.layer.cornerRadius = (self.learnMoreButton.frame.height / 2)
        
        self.bottomSheetCollapsed.backgroundColor = UIColor.basicsBarBlue
        self.bottomSheetDragHandle.backgroundColor = UIColor.whiteText
        self.bottomSheetLabel.text = "THE BASICS"
        self.bottomSheetLabel.font = UIFont.buttonFont
        self.bottomSheetLabel.textColor = UIColor.whiteText
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.infoCardBackgroundImageWidth.constant = self.infoCard.bounds.width * 0.3
        self.infoCardBackgroundImageHeight.constant = self.infoCard.bounds.height * 0.4
    }
    
    //
    // MARK: Private Methods
    //
    private func buildBodyText() -> NSMutableAttributedString {
        let paragraph1Text = "The City has kicked off a pilot program for new dockless bike and electric scooter services.\n"
        let paragraph1Attributes = [NSAttributedStringKey.font: UIFont.introCardBody]
        let paragraph1 = NSMutableAttributedString(string: paragraph1Text, attributes: paragraph1Attributes)
        let paragraph2Part1Attrs = [NSAttributedStringKey.font: UIFont.introCardBody]
        let paragraph2Part1 = NSAttributedString(string: "They plan to ", attributes: paragraph2Part1Attrs)
        let paragraph2Part2 = NSAttributedString(string: "privatize ", attributes: [NSAttributedStringKey.font: UIFont.introCardBodyBold])
        let paragraph2Part3Text = "these dockless operations, rather than adding on to the city's public B-cycle service."
        let paragraph2Part3 = NSAttributedString(string: paragraph2Part3Text, attributes: [NSAttributedStringKey.font: UIFont.introCardBody])
        let paragraph2 = NSMutableAttributedString(attributedString: paragraph2Part1)
        paragraph2.append(paragraph2Part2)
        paragraph2.append(paragraph2Part3)
        let bodyText = NSMutableAttributedString(attributedString: paragraph1)
        bodyText.append(paragraph2)
        return bodyText
    }
}
