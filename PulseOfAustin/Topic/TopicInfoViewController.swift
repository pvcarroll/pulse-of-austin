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
    @IBOutlet var infoCard: UIView!
    @IBOutlet var infoCardBackgroundImageWidth: NSLayoutConstraint!
    @IBOutlet var infoCardBackgroundImageHeight: NSLayoutConstraint!
    @IBOutlet var topicInfoCardTitle: UILabel!
    @IBOutlet var topicInfoCardBody: UILabel!
    @IBOutlet var nextScreenLabel: UILabel!
    @IBOutlet var bottomSheetHandle: UIView!
    @IBOutlet var bottomSheetHandleBottomConstraint: NSLayoutConstraint!
    @IBOutlet var bottomSheetHandleLabel: UILabel!
    @IBOutlet var bottomSheetExpanded: UIView!
    @IBOutlet var bottomSheetExpandedTitle: UILabel!
    @IBOutlet var bottomSheetBodyText: UILabel!
    
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
        self.topicInfoCardTitle.text = topicInfoMessages[0].title
        self.topicInfoCardTitle.font = UIFont.cardTitle
        self.topicInfoCardTitle.textColor = UIColor.customDarkText
        self.topicInfoCardBody.text = topicInfoMessages[0].body
        self.topicInfoCardBody.font = UIFont.introCardBody
        self.topicInfoCardBody.textColor = UIColor.customDarkText
        self.nextScreenLabel.text = topicInfoMessages[1].title
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
}
