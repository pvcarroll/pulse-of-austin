//
//  TopicInfoViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/22/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

//fileprivate let topicInfoMessages: [TopicInfoText] = [
//TopicInfoText(title: "TRANSPARENCY",
//              body: "Data from dockless bikes could help the city prioritize bike infastructure, but a lot of dockless bike companies will not make this data open."),
//TopicInfoText(title: "HONESTY",
//              body: "Ofo, 1 of 10 companies Austin is considering, even reported false data in Aurora, CO, claiming 2.5 daily rides per bike, when they were really clocking 0.18 daily rides."),
//TopicInfoText(title: "PRIVACY",
//              body: "Some dockless bike companies track users even when they are not using the bikes, reserving the right to sell that data to third parties."),
//TopicInfoText(title: "WEIGH IN",
//              body: "What is essential for Austin to consider in its bikeshare data policy?"),
//TopicInfoText(title: "WEIGH IN", body: "")
//]

enum AnswerIndex {
    case answerChoice1
    case answerChoice2
    case answerChoice3
    case answerChoice4
    
    func elaborateKey() -> String {
        switch self {
        case .answerChoice1:
            return "elaborate1"
        case .answerChoice2:
            return "elaborate2"
        case .answerChoice3:
            return "elaborate3"
        case .answerChoice4:
            return "elaborate4"
        }
    }
}

class TopicInfoViewController: UIViewController {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var topicInfoScreenTitle: UILabel!
    @IBOutlet var learnButton: UIButton!
    @IBOutlet var learnButtonUnderline: UIView!
    @IBOutlet var weighInButton: UIButton!
    @IBOutlet var weighInButtonUnderline: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet var infoCard: UIView!
    @IBOutlet var infoCardBottomConstraint: NSLayoutConstraint!
    @IBOutlet var infoCardBackgroundImageWidth: NSLayoutConstraint!
    @IBOutlet var infoCardBackgroundImageHeight: NSLayoutConstraint!
    @IBOutlet var cardContentView: UIView!
    @IBOutlet var continueView: UIView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextScreenLabel: UILabel!
    
    var selectedTopicKey: Int?
    private var cardIndex = 0
    private var selectedAnswer: AnswerIndex?
    private var weighInText: WeighInSelectText?
    private var elaborateView: WeighInElaborate?
    
    @IBAction func learnButtonTapped(_ sender: Any) {
        self.learnButtonUnderline.backgroundColor = UIColor.customDarkText
        self.weighInButtonUnderline.backgroundColor = UIColor.basicsBarBlue
        self.loadLearnLanding()
    }
    @IBAction func weighInButtonTapped(_ sender: Any) {
        self.weighInButtonUnderline.backgroundColor = UIColor.customDarkText
        self.learnButtonUnderline.backgroundColor = UIColor.basicsBarBlue
        self.loadWeighInSelect()
    }
    
    //
    // MARK: Lifecycle Methods
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weighInText = TopicData.topics[self.selectedTopicKey!]?.weighIn
        self.contentView.backgroundColor = UIColor.infoCardBackground
        
        // HEADER
        self.topicInfoScreenTitle.text = TopicData.topics[self.selectedTopicKey!]?.topicInfoTitle
        self.topicInfoScreenTitle.font = UIFont.screenTitle
        self.topicInfoScreenTitle.textColor = UIColor.customDarkText
        
        self.learnButton.backgroundColor = UIColor.basicsBarBlue
        self.learnButton.setTitle("LEARN", for: .normal)
        self.learnButton.titleLabel?.font = UIFont.buttonFont
        self.learnButton.setTitleColor(UIColor.whiteText, for: .normal)
        self.learnButtonUnderline.backgroundColor = UIColor.customDarkText
        
        self.weighInButton.backgroundColor = UIColor.basicsBarBlue
        self.weighInButton.setTitle("WEIGH IN", for: .normal)
        self.weighInButton.titleLabel?.font = UIFont.buttonFont
        self.weighInButton.setTitleColor(UIColor.whiteText, for: .normal)
        self.weighInButtonUnderline.backgroundColor = UIColor.basicsBarBlue
        
        // Dynamic card contents
//        self.nextScreenLabel.text = topicInfoMessages[cardIndex + 1].title

//        let continueGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(continueTapped(recognizer:)))
//        self.continueView.addGestureRecognizer(continueGestureRecognizer)
        
//        self.nextScreenLabel.font =
        self.nextScreenLabel.textColor = UIColor.customYellow
        
        self.loadLearnLanding()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.infoCardBackgroundImageWidth.constant = self.view.bounds.width * 0.6
        self.infoCardBackgroundImageHeight.constant = self.view.bounds.height * 0.5
    }
    
    //
    // MARK: Learn Flow
    //
    
    // Learn Screen 1: Landing
    private func loadLearnLanding() {
        if let landingView = UINib(nibName: "LearnLanding", bundle: nil)
            .instantiate(withOwner: self, options: nil).first as! LearnLanding? {
            landingView.frame = CGRect(x: 0,
                                       y: self.headerView.frame.maxY,
                                       width: self.contentView.frame.width,
                                       height: self.contentView.frame.height - self.headerView.frame.maxY)
            let scrollViewHeight = landingView.stackView.frame.height + landingView.milestoneView.frame.height + 40
            landingView.contentSize = CGSize(width: landingView.frame.width,
                                             height: scrollViewHeight)
            landingView.tag = 1
            let infoRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.loadLearnOverview))
            landingView.info.addGestureRecognizer(infoRecognizer)
            self.updateView(newView: landingView)
        }
    }
    
    // Learn Screen 2: Overview
    @objc private func loadLearnOverview() {
        self.pageControl.numberOfPages = 4
        self.pageControl.currentPage = 0
        let scrollView = UIScrollView(frame: self.cardContentView.bounds)
        scrollView.isPagingEnabled = true
        let learnText = TopicData.topics[self.selectedTopicKey ?? 0]?.learnText
        // Overview Card
        if let learnOverviewView = UINib(nibName: "LearnOverview", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! LearnOverview? {
            learnOverviewView.frame = self.cardContentView.bounds
            let overviewCardText = learnText?.overviewText
            overviewCardText?.forEach {
                let label = UILabel(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 1,
                                                  height: CGFloat.greatestFiniteMagnitude))
                label.numberOfLines = 0
                label.lineBreakMode = .byWordWrapping
                label.font = UIFont.introCardBody
                label.text = $0
                label.sizeToFit()
                learnOverviewView.bodyTextStackView.addArrangedSubview(label)
            }
            scrollView.addSubview(learnOverviewView)
            scrollView.contentSize = learnOverviewView.frame.size
        }
        // Breakdown Card
        if let learnBreakdownView = UINib(nibName: "LearnBreakdown", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! LearnBreakdown? {
            learnBreakdownView.frame = CGRect(x: self.cardContentView.bounds.width,
                                              y: 0,
                                              width: self.cardContentView.bounds.width,
                                              height: self.cardContentView.bounds.height)
            learnBreakdownView.breakdownTitle.text = learnText?.breakdownTitle
            if let breakdownAmountsText = learnText?.breakdownAmountsText,
                let breakdownDescriptionsText = learnText?.breakdownDescriptionsText {
                for i in 0..<breakdownAmountsText.count {
                    if let breakdownRow = UINib(nibName: "BreakdownView", bundle: nil)
                        .instantiate(withOwner: self, options: nil).first as! BreakdownView? {
                        breakdownRow.amountLabel.text = breakdownAmountsText[i]
                        breakdownRow.descriptionLabel.text = breakdownDescriptionsText[i]
                        breakdownRow.amountLabel.sizeToFit()
                        breakdownRow.descriptionLabel.sizeToFit()
                        breakdownRow.sizeToFit()
                        learnBreakdownView.breakdownStackView.addArrangedSubview(breakdownRow)
                    }
                }
            }
            
            scrollView.addSubview(learnBreakdownView)
            scrollView.contentSize.width += learnBreakdownView.frame.width
        }
        
        self.updateCardContents(newView: scrollView)
    }
    
    // Learn Screen 3: Bond Breakdown
    // Learn Screen 4: On the Ballot
    // Learn Screen 5: Perspectives
    
    //
    // MARK: Weigh In Flow
    //
    
    // Weigh In Screen 1: Select
    private func loadWeighInSelect() {
        // TODO: Dynamic numberOfPages
        self.pageControl.numberOfPages = 3
        self.continueView.isHidden = true
        if let weighInSelectView = UINib(nibName: "WeighInSelect", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! WeighInSelect? {
            
            weighInSelectView.frame = self.cardContentView.bounds
            
            weighInSelectView.answer1Button.setTitle(self.weighInText?.choices[0], for: .normal)
            weighInSelectView.answer2Button.setTitle(self.weighInText?.choices[1], for: .normal)
            weighInSelectView.answer3Button.setTitle(self.weighInText?.choices[2], for: .normal)
            
            weighInSelectView.answer1Button.addTarget(self, action: #selector(self.answer1Selected), for: .touchUpInside)
            weighInSelectView.answer2Button.addTarget(self, action: #selector(self.answer2Selected), for: .touchUpInside)
            weighInSelectView.answer3Button.addTarget(self, action: #selector(self.answer3Selected), for: .touchUpInside)
            
            self.updateCardContents(newView: weighInSelectView)
        }
    }
    
    // Weigh In Screen 2: Elaborate
    private func loadWeighInElaborate(answerText: String) {
        self.pageControl.currentPage = 1
        if let elaborateView = UINib(nibName: "WeighInElaborate", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! WeighInElaborate? {
            self.elaborateView = elaborateView
            elaborateView.frame = self.cardContentView.bounds
            var cardTitleText = "ELABORATE"
            // TODO: Dynamic "other" text
            if answerText == "Other Thoughts" {
                elaborateView.submitButton.isUserInteractionEnabled = false
            } else {
                cardTitleText += " (OPTIONAL)"
            }
            elaborateView.cardTitle.text = cardTitleText
            elaborateView.selectedAnswerButton.setTitle(answerText, for: .normal)
            elaborateView.selectedAnswerButton.addTarget(self, action: #selector(self.selectedAnswerButtonTapped), for: .touchUpInside)
            let submitGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(submitTapped(recognizer:)))
            elaborateView.submitButton.addGestureRecognizer(submitGestureRecognizer)
            
            self.updateCardContents(newView: elaborateView)
        }
    }
    
    @objc private func selectedAnswerButtonTapped() {
        self.loadWeighInSelect()
    }
    
    // Weigh In Screen 3: Results
    private func loadWeighInResults() {
        self.pageControl.currentPage = 2
        if let resultsView = UINib(nibName: "WeighInResults", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! WeighInResults? {
            resultsView.frame = self.cardContentView.bounds
            
            // TODO: Hide 4th response view if only 3 responses
            resultsView.response4View.isHidden = true
            
            resultsView.response1Label.text = self.weighInText?.choices[0]
            resultsView.response2Label.text = self.weighInText?.choices[1]
            if (self.weighInText?.choices.count)! > 3 {
                resultsView.response3Label.text = self.weighInText?.choices[2]
                resultsView.response4Label.text = "Other"
            } else {
                resultsView.response3Label.text = "Other"
            }
            
            // Set response bar lengths based on count
            if let dbRef = (UIApplication.shared.delegate as! AppDelegate).dbRef,
                let topicKey = TopicData.topics[self.selectedTopicKey!]?.topicKey {
                
                let answerCountsPath = "weighIn/\(topicKey)/answerChoiceCounts"
                
                dbRef.child(answerCountsPath).observeSingleEvent(of: .value, with: { (snapshot) in
                    guard let values = snapshot.value as? [String: Any] else {return}
                    let answerChoice1 = values["answerChoice1"] as? Int
                    let answerChoice2 = values["answerChoice2"] as? Int
                    let answerChoice3 = values["answerChoice3"] as? Int
                    let answerChoice4 = values["answerChoice4"] as? Int
                    
                    guard var maxCount = answerChoice1 else {return}
                    for answerChoiceCount in [answerChoice1, answerChoice2, answerChoice3, answerChoice4] {
                        if let count = answerChoiceCount, count > maxCount {
                            maxCount = count
                        }
                    }
                    
                    // Set counts and bar lengths
                    let maxWidth = resultsView.response1View.frame.width - resultsView.response1Count.frame.width
                    
                    let talliesBarHeight = resultsView.response1Tallies.frame.size.height
                    if let count1 = answerChoice1 {
                        resultsView.response1Tallies.frame.size = CGSize(width: maxWidth * CGFloat(count1) / CGFloat(maxCount), height: talliesBarHeight)
                        resultsView.response1Count.text = String(count1)
                    }
                    if let count2 = answerChoice2 {
                        resultsView.response2Tallies.frame.size = CGSize(width: maxWidth * CGFloat(count2) / CGFloat(maxCount), height: talliesBarHeight)
                        resultsView.response2Count.text = String(count2)
                    }
                    if let count3 = answerChoice3 {
                        resultsView.response3Tallies.frame.size = CGSize(width: maxWidth * CGFloat(count3) / CGFloat(maxCount), height: talliesBarHeight)
                        resultsView.response3Count.text = String(count3)
                    }
                    if let count4 = answerChoice4 {
                        resultsView.response4Tallies.frame.size = CGSize(width: maxWidth * CGFloat(count4) / CGFloat(maxCount), height: talliesBarHeight)
                        resultsView.response4Count.text = String(count4)
                    }
                })
            }
            self.updateCardContents(newView: resultsView)
        }
    }
    
    // MARK: Private Methods
    
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
    
    private func updateCardContents(newView: UIView) {
        for subview in self.contentView.subviews {
            if subview.tag == 1 {
                subview.removeFromSuperview()
            }
        }
        self.cardContentView.subviews.forEach { $0.removeFromSuperview() }
        self.cardContentView.addSubview(newView)
    }
    
    private func updateView(newView: UIView) {
        self.contentView.insertSubview(newView, at: self.contentView.subviews.count)
    }
    
    //
    // MARK: Event Handlers
    //
    
    @objc func answer1Selected(sender: UIButton!) {
        self.selectedAnswer = .answerChoice1
        let answerText = sender.titleLabel?.text! ?? ""
        self.loadWeighInElaborate(answerText: answerText)
    }
    @objc func answer2Selected(sender: UIButton!) {
        self.selectedAnswer = .answerChoice2
        let answerText = sender.titleLabel?.text! ?? ""
        self.loadWeighInElaborate(answerText: answerText)
    }
    @objc func answer3Selected(sender: UIButton!) {
        self.selectedAnswer = .answerChoice3
        let answerText = sender.titleLabel?.text! ?? ""
        self.loadWeighInElaborate(answerText: answerText)
    }
    @objc func submitTapped(recognizer: UITapGestureRecognizer) {
        
        if let dbRef = (UIApplication.shared.delegate as! AppDelegate).dbRef,
           let topicKey = TopicData.topics[self.selectedTopicKey!]?.topicKey,
           let answer = self.selectedAnswer {
            
            let responsesPath = "weighIn/\(topicKey)/answerChoiceCounts/\(answer)"
            let elaboratePath = "weighIn/\(topicKey)/elaborateResponses/\(answer.elaborateKey())"
            
            dbRef.child(responsesPath).observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? NSInteger {
                    dbRef.child(responsesPath).setValue(value + 1)
                } else {
                    dbRef.child(responsesPath).setValue(1)
                }
                // TODO: save elaborate text
                let elaborateResponse = self.elaborateView?.response
                if !(elaborateResponse ?? "").isEmpty {
                    dbRef.child(elaboratePath).childByAutoId().setValue(elaborateResponse)
                }
            })
        }
        self.loadWeighInResults()
    }
    
    // LEARN FLOW
//    @objc func continueTapped(recognizer: UITapGestureRecognizer) {
//        self.cardIndex = (cardIndex < topicInfoMessages.count - 1) ? (self.cardIndex + 1) : 0
//        self.pageControl.currentPage = self.cardIndex
//        let isWeighInCard1: Bool = (cardIndex == topicInfoMessages.count - 2)
//        let isWeighInCard2: Bool = (cardIndex == topicInfoMessages.count - 1)
//        if self.cardIndex < topicInfoMessages.count - 1 {
//            self.nextScreenLabel.text = topicInfoMessages[cardIndex + 1].title
//        }
//        if isWeighInCard1 {
//            self.continueView.isHidden = true
//        } else if isWeighInCard2 {
//            self.continueView.isHidden = true
//        } else {
//            self.continueView.isHidden = false
//        }
//    }
}
