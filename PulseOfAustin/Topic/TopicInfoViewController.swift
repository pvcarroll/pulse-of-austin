//
//  TopicInfoViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/22/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

struct TopicInfoText {
    let title: String
    let body: String
}

fileprivate let topicInfoMessages: [TopicInfoText] = [
TopicInfoText(title: "TRANSPARENCY",
              body: "Data from dockless bikes could help the city prioritize bike infastructure, but a lot of dockless bike companies will not make this data open."),
TopicInfoText(title: "HONESTY",
              body: "Ofo, 1 of 10 companies Austin is considering, even reported false data in Aurora, CO, claiming 2.5 daily rides per bike, when they were really clocking 0.18 daily rides."),
TopicInfoText(title: "PRIVACY",
              body: "Some dockless bike companies track users even when they are not using the bikes, reserving the right to sell that data to third parties."),
TopicInfoText(title: "WEIGH IN",
              body: "What is essential for Austin to consider in its bikeshare data policy?"),
TopicInfoText(title: "WEIGH IN", body: "")
]

class TopicInfoViewController: UIViewController {
    
    private var cardIndex = 0
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var topicInfoScreenTitle: UILabel!
    @IBOutlet var infoCard: UIView!
    @IBOutlet var infoCardBackgroundImageWidth: NSLayoutConstraint!
    @IBOutlet var infoCardBackgroundImageHeight: NSLayoutConstraint!
    @IBOutlet var topicInfoCardTitle: UILabel!
    @IBOutlet var topicInfoCardBody: UILabel!
    @IBOutlet var answerChoicesStackView: UIStackView!
    @IBOutlet var answerChoicesStackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var answerChoice1Button: UIButton!
    @IBOutlet var answerChoice2Button: UIButton!
    @IBOutlet var answerChoice3Button: UIButton!
    @IBOutlet var continueView: UIView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextScreenLabel: UILabel!
    @IBOutlet var bottomSheetHandle: UIView!
    @IBOutlet var bottomSheetHandleBottomConstraint: NSLayoutConstraint!
    @IBOutlet var bottomSheetHandleLabel: UILabel!
    @IBOutlet var bottomSheetExpanded: UIView!
    @IBOutlet var bottomSheetExpandedTitle: UILabel!
    @IBOutlet var bottomSheetBodyText: UILabel!
    
    @IBAction func button1Tapped(_ sender: Any) {
        self.answerChoice2Button.isHidden = true
        self.answerChoice3Button.isHidden = true
        self.continueTapped(recognizer: UITapGestureRecognizer())
    }
    @IBAction func button2Tapped(_ sender: Any) {
        self.answerChoice1Button.isHidden = true
        self.answerChoice3Button.isHidden = true
        self.continueTapped(recognizer: UITapGestureRecognizer())
    }
    @IBAction func button3Tapped(_ sender: Any) {
        self.answerChoice1Button.isHidden = true
        self.answerChoice2Button.isHidden = true
        self.continueTapped(recognizer: UITapGestureRecognizer())
    }
    //
    // MARK: Lifecycle Methods
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.backgroundColor = UIColor.infoCardBackground
        self.topicInfoScreenTitle.text = "Dockless Bikeshare"
        self.topicInfoScreenTitle.font = UIFont.screenTitle
        self.topicInfoScreenTitle.textColor = UIColor.customDarkText
        
        // Dynamic card contents
        self.topicInfoCardTitle.text = topicInfoMessages[cardIndex].title
        self.topicInfoCardBody.text = topicInfoMessages[cardIndex].body
        self.nextScreenLabel.text = topicInfoMessages[cardIndex + 1].title
        
        self.topicInfoCardTitle.font = UIFont.cardTitle
        self.topicInfoCardTitle.textColor = UIColor.customDarkText
        self.topicInfoCardBody.font = UIFont.introCardBody
        self.topicInfoCardBody.textColor = UIColor.customDarkText
        
        let continueGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(continueTapped(recognizer:)))
        self.continueView.addGestureRecognizer(continueGestureRecognizer)
        
//        self.nextScreenLabel.font =
        self.nextScreenLabel.textColor = UIColor.customYellow
        
        let bottomSheetTouchRecognizer = UITapGestureRecognizer(target: self, action: #selector(bottomSheetHandleTapped(recognizer:)))
        self.bottomSheetHandle.addGestureRecognizer(bottomSheetTouchRecognizer)
        
        self.bottomSheetHandle.backgroundColor = UIColor.basicsBarBlue
        self.bottomSheetHandleLabel.text = "THE BASICS"
        self.bottomSheetHandleLabel.font = UIFont.buttonFont
        self.bottomSheetHandleLabel.textColor = UIColor.whiteText
        
        self.bottomSheetExpanded.isHidden = true
        self.bottomSheetExpanded.backgroundColor = UIColor.whiteBackground
        self.bottomSheetExpandedTitle.text = "TRANSPORTATION IN AUSTIN"
        self.bottomSheetExpandedTitle.font = UIFont.cardTitle
        self.bottomSheetExpandedTitle.textColor = UIColor.customDarkText
        self.bottomSheetBodyText.attributedText = buildBottomSheetList()
        self.bottomSheetBodyText.font = UIFont.introCardBody
        self.bottomSheetBodyText.textColor = UIColor.customDarkText
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.infoCardBackgroundImageWidth.constant = self.infoCard.bounds.width * 0.3
        self.infoCardBackgroundImageHeight.constant = self.infoCard.bounds.height * 0.45
    }
    
    //
    // MARK: Private Methods
    //
    
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
    // MARK: Gesture Handler
    //
    
    @objc func bottomSheetHandleTapped(recognizer: UITapGestureRecognizer) {
        if self.bottomSheetExpanded.isHidden {
            self.bottomSheetExpanded.isHidden = false
            self.bottomSheetHandleBottomConstraint.constant =  self.bottomSheetExpanded.frame.height
        } else {
            self.bottomSheetExpanded.isHidden = true
            self.bottomSheetHandleBottomConstraint.constant =  0
        }
    }
    
    // Show messages for next card
    @objc func continueTapped(recognizer: UITapGestureRecognizer) {
        self.cardIndex = (cardIndex < topicInfoMessages.count - 1) ? (self.cardIndex + 1) : 0
        self.pageControl.currentPage = self.cardIndex
        let isWeighInCard1: Bool = (cardIndex == topicInfoMessages.count - 2)
        let isWeighInCard2: Bool = (cardIndex == topicInfoMessages.count - 1)
        self.topicInfoCardTitle.text = topicInfoMessages[self.cardIndex].title
        self.topicInfoCardBody.text = topicInfoMessages[self.cardIndex].body
        if self.cardIndex < topicInfoMessages.count - 1 {
            self.nextScreenLabel.text = topicInfoMessages[cardIndex + 1].title
        }
        if isWeighInCard1 {
            self.answerChoice1Button.setTitle("Collect data on bike rides only + share with city", for: .normal)
            self.answerChoice2Button.setTitle("Collect data for city use only", for: .normal)
            self.answerChoice3Button.setTitle("Minimize rental cost - allow all data collections", for: .normal)
            self.answerChoice1Button.setTitleColor(UIColor.customDarkText, for: .normal)
            self.answerChoice2Button.setTitleColor(UIColor.customDarkText, for: .normal)
            self.answerChoice3Button.setTitleColor(UIColor.customDarkText, for: .normal)
            self.answerChoice1Button.backgroundColor = UIColor.infoCardBackground
            self.answerChoice2Button.backgroundColor = UIColor.infoCardBackground
            self.answerChoice3Button.backgroundColor = UIColor.infoCardBackground
            self.answerChoice1Button.titleLabel?.numberOfLines = 0
            self.answerChoice2Button.titleLabel?.numberOfLines = 0
            self.answerChoice3Button.titleLabel?.numberOfLines = 0
            self.answerChoice1Button.titleLabel?.textAlignment = .center
            self.answerChoice2Button.titleLabel?.textAlignment = .center
            self.answerChoice3Button.titleLabel?.textAlignment = .center
            self.answerChoicesStackView.isHidden = false
            self.continueView.isHidden = true
        } else if isWeighInCard2 {
            self.answerChoicesStackViewBottomConstraint.isActive = false
            self.continueView.isHidden = true
            let textView = UITextView(frame: CGRect(x: 20,
                                                    y: self.answerChoicesStackView.frame.minY + 10,
                                                    width: self.infoCard.frame.width - 40,
                                                    height: 50))
            textView.layer.borderWidth = 1.0
            textView.layer.cornerRadius = 3.0
            textView.becomeFirstResponder()
            let nextButton = UIButton(frame: CGRect(x: self.infoCard.frame.width / 2 - 80,
                                                    y: textView.frame.maxY + 20,
                                                    width: 160, height: 40))
            nextButton.setTitle("NEXT", for: .normal)
            nextButton.setTitleColor(UIColor.customYellow, for: .normal)
            nextButton.layer.borderWidth = 0.5
            nextButton.layer.cornerRadius = nextButton.frame.height / 2
            self.infoCard.addSubview(textView)
            self.infoCard.addSubview(nextButton)
        } else {
            self.answerChoicesStackView.isHidden = true
            self.continueView.isHidden = false
        }
    }
}
