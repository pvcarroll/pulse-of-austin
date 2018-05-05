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
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var topicInfoScreenTitle: UILabel!
    @IBOutlet var learnButton: UIButton!
    @IBOutlet var learnButtonUnderline: UIView!
    @IBOutlet var weighInButton: UIButton!
    @IBOutlet var weighInButtonUnderline: UIView!
    @IBOutlet var infoCard: UIView!
    @IBOutlet var infoCardBottomConstraint: NSLayoutConstraint!
    @IBOutlet var infoCardBackgroundImageWidth: NSLayoutConstraint!
    @IBOutlet var infoCardBackgroundImageHeight: NSLayoutConstraint!
    @IBOutlet var cardContentView: UIView!
    @IBOutlet var continueView: UIView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextScreenLabel: UILabel!
    
    private var cardIndex = 0
    
    @IBAction func learnButtonTapped(_ sender: Any) {
        self.learnButtonUnderline.backgroundColor = UIColor.customDarkText
        self.weighInButtonUnderline.backgroundColor = UIColor.basicsBarBlue
        self.loadLearnView()
    }
    @IBAction func weighInButtonTapped(_ sender: Any) {
        self.weighInButtonUnderline.backgroundColor = UIColor.customDarkText
        self.learnButtonUnderline.backgroundColor = UIColor.basicsBarBlue
        self.loadWeighInView()
    }
    
    //
    // MARK: Lifecycle Methods
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.backgroundColor = UIColor.infoCardBackground
        
        // HEADER
        self.topicInfoScreenTitle.text = "Dockless Bikeshare"
        self.topicInfoScreenTitle.font = UIFont.screenTitle
        self.topicInfoScreenTitle.textColor = UIColor.customDarkText
        
        self.learnButton.backgroundColor = UIColor.basicsBarBlue
        self.learnButton.setTitle("LEARN", for: .normal)
        self.learnButton.setTitleColor(UIColor.whiteText, for: .normal)
        self.learnButtonUnderline.backgroundColor = UIColor.basicsBarBlue
        
        self.weighInButton.backgroundColor = UIColor.basicsBarBlue
        self.weighInButton.setTitle("WEIGH IN", for: .normal)
        self.weighInButton.setTitleColor(UIColor.whiteText, for: .normal)
        self.weighInButtonUnderline.backgroundColor = UIColor.customDarkText
        
        // Dynamic card contents
        self.nextScreenLabel.text = topicInfoMessages[cardIndex + 1].title

        let continueGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(continueTapped(recognizer:)))
        self.continueView.addGestureRecognizer(continueGestureRecognizer)
        
//        self.nextScreenLabel.font =
        self.nextScreenLabel.textColor = UIColor.customYellow
        
        self.loadWeighInView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.infoCardBackgroundImageWidth.constant = self.view.bounds.width * 0.6
        self.infoCardBackgroundImageHeight.constant = self.view.bounds.height * 0.5
    }
    
    //
    // MARK: Private Methods
    //
    
    private func loadWeighInView() {
        self.pageControl.numberOfPages = 4
        self.continueView.isHidden = true
        if let cardContent = UINib(nibName: "WeighInView", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! WeighInView? {
            self.cardContentView.subviews.forEach { $0.removeFromSuperview() }
            cardContent.frame = self.cardContentView.bounds
            cardContent.weighInTextView.isHidden = true
            cardContent.nextButton.isHidden = true
            cardContent.skipButton.isHidden = true
            self.cardContentView.addSubview(cardContent)
        }
    }
    
    private func loadLearnView() {
        if let cardContent = UINib(nibName: "LearnView", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! LearnView? {
            self.cardContentView.subviews.forEach { $0.removeFromSuperview() }
            cardContent.frame = self.cardContentView.bounds
            self.cardContentView.addSubview(cardContent)
        }
    }
    
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
    
    // Show messages for next card
    @objc func continueTapped(recognizer: UITapGestureRecognizer) {
        self.cardIndex = (cardIndex < topicInfoMessages.count - 1) ? (self.cardIndex + 1) : 0
        self.pageControl.currentPage = self.cardIndex
        let isWeighInCard1: Bool = (cardIndex == topicInfoMessages.count - 2)
        let isWeighInCard2: Bool = (cardIndex == topicInfoMessages.count - 1)
        if self.cardIndex < topicInfoMessages.count - 1 {
            self.nextScreenLabel.text = topicInfoMessages[cardIndex + 1].title
        }
        if isWeighInCard1 {
            self.continueView.isHidden = true
        } else if isWeighInCard2 {
            self.continueView.isHidden = true
        } else {
            self.continueView.isHidden = false
        }
    }
}
