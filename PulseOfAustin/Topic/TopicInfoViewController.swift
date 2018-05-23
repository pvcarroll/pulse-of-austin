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
    
    @IBAction func learnButtonTapped(_ sender: Any) {
        self.learnButtonUnderline.backgroundColor = UIColor.customDarkText
        self.weighInButtonUnderline.backgroundColor = UIColor.basicsBarBlue
        self.loadLearnView()
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
        self.learnButtonUnderline.backgroundColor = UIColor.basicsBarBlue
        
        self.weighInButton.backgroundColor = UIColor.basicsBarBlue
        self.weighInButton.setTitle("WEIGH IN", for: .normal)
        self.weighInButton.titleLabel?.font = UIFont.buttonFont
        self.weighInButton.setTitleColor(UIColor.whiteText, for: .normal)
        self.weighInButtonUnderline.backgroundColor = UIColor.customDarkText
        
        // Dynamic card contents
//        self.nextScreenLabel.text = topicInfoMessages[cardIndex + 1].title

//        let continueGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(continueTapped(recognizer:)))
//        self.continueView.addGestureRecognizer(continueGestureRecognizer)
        
//        self.nextScreenLabel.font =
        self.nextScreenLabel.textColor = UIColor.customYellow
        
        self.loadWeighInSelect()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.infoCardBackgroundImageWidth.constant = self.view.bounds.width * 0.6
        self.infoCardBackgroundImageHeight.constant = self.view.bounds.height * 0.5
    }
    
    //
    // MARK: Weigh In Flow
    //
    
    // Weigh In Screen 1
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
            
            let answer1SelectedGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(answer1Selected(recognizer:)))
            let answer2SelectedGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(answer2Selected(recognizer:)))
            let answer3SelectedGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(answer3Selected(recognizer:)))
            
            weighInSelectView.answer1Button.addGestureRecognizer(answer1SelectedGestureRecognizer)
            weighInSelectView.answer2Button.addGestureRecognizer(answer2SelectedGestureRecognizer)
            weighInSelectView.answer3Button.addGestureRecognizer(answer3SelectedGestureRecognizer)
            self.updateCardContents(newView: weighInSelectView)
        }
    }
    
    // Weigh In Screen 2
    private func loadWeighInElaborate(answerText: String) {
        self.pageControl.currentPage = 1
        if let elaborateView = UINib(nibName: "WeighInElaborate", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! WeighInElaborate? {
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
            let submitGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(submitTapped(recognizer:)))
            elaborateView.submitButton.addGestureRecognizer(submitGestureRecognizer)
            
            self.updateCardContents(newView: elaborateView)
        }
    }
    
    // Weigh In Screen 3
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
            
            // TODO: response widths based on count
            
            
            self.updateCardContents(newView: resultsView)
        }
    }
    
    //
    // MARK: Learn Flow
    //
    
    // Learn Screen 1
    private func loadLearnView() {
        // TODO: Dynamic numberOfPages
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        if let cardContent = UINib(nibName: "LearnView", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! LearnView? {
            self.cardContentView.subviews.forEach { $0.removeFromSuperview() }
            cardContent.frame = self.cardContentView.bounds
            self.cardContentView.addSubview(cardContent)
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
        self.cardContentView.subviews.forEach { $0.removeFromSuperview() }
        self.cardContentView.addSubview(newView)
    }
    
    //
    // MARK: Event Handlers
    //
    
    @objc func answer1Selected(recognizer: UITapGestureRecognizer) {
        self.selectedAnswer = .answerChoice1
        let answerText = (recognizer.view as! UIButton).titleLabel?.text! ?? ""
        self.loadWeighInElaborate(answerText: answerText)
    }
    @objc func answer2Selected(recognizer: UITapGestureRecognizer) {
        self.selectedAnswer = .answerChoice2
        let answerText = (recognizer.view as! UIButton).titleLabel?.text! ?? ""
        self.loadWeighInElaborate(answerText: answerText)
    }
    @objc func answer3Selected(recognizer: UITapGestureRecognizer) {
        self.selectedAnswer = .answerChoice3
        let answerText = (recognizer.view as! UIButton).titleLabel?.text! ?? ""
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
                dbRef.child(elaboratePath).childByAutoId().setValue("bullshit")
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
