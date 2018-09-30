//
//  TopicInfoViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/22/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit
import Firebase

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
    @IBOutlet var learnButton: UIButton!
    @IBOutlet var learnButtonUnderline: UIView!
    @IBOutlet var weighInButton: UIButton!
    @IBOutlet var weighInButtonUnderline: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet var topicInfoViewContainer: UIView!
    @IBOutlet var infoCardBottomConstraint: NSLayoutConstraint!
    @IBOutlet var pageControl: UIPageControl!
    
    var selectedTopicKey: Int?
    private var cardIndex = 0
    private var selectedAnswer: AnswerIndex?
    private var learnText: LearnText?
    private var weighInText: WeighInSelectText?
    private var elaborateView: WeighInElaborate?
    private var cardFrame: CGRect?
    private var learnCardTextViews: [UITextView] = []
    
    @IBAction func learnButtonTapped(_ sender: Any) {
        self.learnButtonUnderline.backgroundColor = UIColor.darkGray74
        self.weighInButtonUnderline.backgroundColor = UIColor.basicsBarBlue
        self.loadLearnLanding()
    }
    @IBAction func weighInButtonTapped(_ sender: Any) {
        self.weighInButtonUnderline.backgroundColor = UIColor.darkGray74
        self.learnButtonUnderline.backgroundColor = UIColor.basicsBarBlue
        self.loadWeighInLanding()
    }
    
    //
    // MARK: Lifecycle Methods
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.learnText = TopicData.topics[self.selectedTopicKey!]?.learnText
        self.weighInText = TopicData.topics[self.selectedTopicKey!]?.weighIn
        self.contentView.backgroundColor = UIColor.infoCardBackground
        
        let screenTitle = TopicData.topics[self.selectedTopicKey!]?.topicInfoTitle
        self.title = screenTitle

        self.learnButton.backgroundColor = UIColor.basicsBarBlue
        self.learnButton.setTitle("LEARN", for: .normal)
        self.learnButton.titleLabel?.font = UIFont.buttonFont
        self.learnButton.setTitleColor(UIColor.darkText, for: .normal)
        self.learnButtonUnderline.backgroundColor = UIColor.darkGray74
        
        self.weighInButton.backgroundColor = UIColor.basicsBarBlue
        self.weighInButton.setTitle("WEIGH IN", for: .normal)
        self.weighInButton.titleLabel?.font = UIFont.buttonFont
        self.weighInButton.setTitleColor(UIColor.darkText, for: .normal)
        self.weighInButtonUnderline.backgroundColor = UIColor.basicsBarBlue
        
        self.loadLearnLanding()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.cardFrame = CGRect(x: 20,
                                y: 10,
                                width: self.topicInfoViewContainer.frame.width - 30,
                                height: self.topicInfoViewContainer.frame.height - 40)
        // Load learn cards with content at top instead of scrolled to bottom
        self.learnCardTextViews.forEach {
            $0.setContentOffset(CGPoint.zero, animated: false)
        }
    }
    
    //
    // MARK: Learn Flow
    //
    
    // Learn Screen 1: Landing
    private func loadLearnLanding() {
        if let landingView = UINib(nibName: "LearnLanding", bundle: nil)
                            .instantiate(withOwner: self, options: nil).first as! LearnLanding? {
            landingView.frame = self.topicInfoViewContainer.bounds
            landingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            landingView.infoLabel.text = self.learnText?.landingInfoLabel
            landingView.mapLabel.text = self.learnText?.landingMapLabel
            let scrollViewHeight = landingView.stackView.frame.height + landingView.milestoneView.frame.height + 40
            landingView.contentSize = CGSize(width: landingView.frame.width,
                                             height: scrollViewHeight)
            let infoRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.loadLearnCards))
            landingView.info.addGestureRecognizer(infoRecognizer)
            let mapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.loadLearnMap))
            landingView.map.addGestureRecognizer(mapRecognizer)
            self.updateViewContent(newView: landingView)
        }
    }
    
    // Learn Screen 2: Learn Scroll View
    @objc private func loadLearnCards() {
        guard let learnCardFrame = self.cardFrame else { return }
        guard let cardsContainer = UINib(nibName: "LearnCardsContainer", bundle: nil).instantiate(withOwner: self, options: nil).first as! LearnCardsContainer? else { return }
        cardsContainer.frame = self.topicInfoViewContainer.bounds
        let cardsScrollView = cardsContainer.scrollView
        cardsScrollView?.contentSize.height = 1.0
        
        // Insert card content for each slide into HTML template
        var htmlSlides = [String]()
        let htmlTemplate = HTMLStrings.htmlTemplate
        for cardContent in HTMLStrings.affordableHousingCardContent {
            htmlSlides.append(htmlTemplate.replacingOccurrences(of: "#HTML_CONTENT#", with: cardContent))
        }

        // Create cards and add to scroll view
        for i in 0..<htmlSlides.count {
            guard let card = UINib(nibName: "LearnCard", bundle: nil).instantiate(withOwner: self, options: nil).first as! LearnCard? else { return }
            
            let cardWidth = learnCardFrame.width
            card.frame = CGRect(origin: CGPoint(x: CGFloat(i) * cardWidth,
                                                y: 0),
                                size: learnCardFrame.size)
            // First card opaque, others translucent
            card.alpha = ((i == 0) ? 1.0 : 0.5)
            card.webView.loadHTMLString(htmlSlides[i], baseURL: nil)
            card.pageControl.numberOfPages = htmlSlides.count
            card.pageControl.currentPage = i
            card.xButton.addTarget(self, action: #selector(TopicInfoViewController.learnCardXTapped), for: .touchDown)
            cardsScrollView?.addSubview(card)
            cardsScrollView?.contentSize.width += card.frame.width
        }
        
        self.updateViewContent(newView: cardsContainer)
    }
    
    // Learn Map
    @objc private func loadLearnMap() {
        if let learnMapView = UINib(nibName: "LearnMap", bundle: nil).instantiate(withOwner: self, options: nil).first as! LearnMap? {
            learnMapView.frame = self.topicInfoViewContainer.bounds
            self.updateViewContent(newView: learnMapView)
        }
    }
    
    //
    // MARK: Weigh In Flow
    //
    
    // Weigh In Screen 1: Landing
    private func loadWeighInLanding() {
        if let landingView = UINib(nibName: "WeighInLanding", bundle: nil)
            .instantiate(withOwner: self, options: nil).first as! WeighInLanding? {
            landingView.frame = self.topicInfoViewContainer.bounds
            landingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            let scrollViewHeight = landingView.stackView.frame.height + 15 + 15
            landingView.contentSize = CGSize(width: landingView.frame.width,
                                             height: scrollViewHeight)
            let infoRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.startWeighIn))
            landingView.one.addGestureRecognizer(infoRecognizer)
            self.updateViewContent(newView: landingView)
        }
    }
    
    // Weigh In Screen 2: Select
    private func loadWeighInSelect() {
        // TODO: Dynamic numberOfPages
        self.pageControl.numberOfPages = 3
        if let weighInSelectView = UINib(nibName: "WeighInSelect", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! WeighInSelect?,
                let weightInCardFrame = self.cardFrame {
            
            weighInSelectView.frame = weightInCardFrame
            
            weighInSelectView.answer1Button.setTitle(self.weighInText?.choices[0], for: .normal)
            weighInSelectView.answer2Button.setTitle(self.weighInText?.choices[1], for: .normal)
            weighInSelectView.answer3Button.setTitle(self.weighInText?.choices[2], for: .normal)
            
            weighInSelectView.answer1Button.addTarget(self, action: #selector(self.answer1Selected), for: .touchUpInside)
            weighInSelectView.answer2Button.addTarget(self, action: #selector(self.answer2Selected), for: .touchUpInside)
            weighInSelectView.answer3Button.addTarget(self, action: #selector(self.answer3Selected), for: .touchUpInside)
            
            self.updateViewContent(newView: weighInSelectView)
        }
    }
    
    // Weigh In Screen 3: Elaborate
    private func loadWeighInElaborate(answerText: String) {
        self.pageControl.currentPage = 1
        if let elaborateView = UINib(nibName: "WeighInElaborate", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! WeighInElaborate?,
                let weightInCardFrame = self.cardFrame {
            self.elaborateView = elaborateView
            elaborateView.frame = weightInCardFrame
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
            let submitGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(submitWeighInTapped(recognizer:)))
            elaborateView.submitButton.addGestureRecognizer(submitGestureRecognizer)
            
            self.updateViewContent(newView: elaborateView)
        }
    }
    
    @objc private func selectedAnswerButtonTapped() {
        self.loadWeighInSelect()
    }
    
    // Weigh In Screen 4: Results
    private func loadWeighInResults() {
        self.pageControl.currentPage = 2
        if let resultsView = UINib(nibName: "WeighInResults", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! WeighInResults?,
                let weightInCardFrame = self.cardFrame {
            resultsView.frame = weightInCardFrame
            
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
            // TODO: Move db code out of VC
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
            self.updateViewContent(newView: resultsView)
        }
    }
    
    //
    // MARK: Event Handlers
    //
    
    @objc func learnCardXTapped(sender: UIButton!) {
        self.loadLearnLanding()
    }
    @objc func startWeighIn() {
        self.loadWeighInSelect()
    }
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
    @objc func submitWeighInTapped(recognizer: UITapGestureRecognizer) {
        guard let _ = Auth.auth().currentUser else {
            self.presentLogin()
            return
        }
        self.saveWeighInResponse()
    }
    
    // MARK: Private Methods
    
    private func updateViewContent(newView: UIView) {
        self.topicInfoViewContainer.subviews.forEach { $0.removeFromSuperview() }
        self.topicInfoViewContainer.addSubview(newView)
    }
    private func presentLogin() {
        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginVC.isIntervention = true
        loginVC.completionHandler = { [weak self] in
            // After login completes, save response, and transition to results
            self?.saveWeighInResponse()
        }
        self.present(loginVC, animated: true, completion: nil)
    }
    private func saveWeighInResponse() {
        // TODO: move db code
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
                let elaborateResponse = self.elaborateView?.response
                if !(elaborateResponse ?? "").isEmpty {
                    dbRef.child(elaboratePath).childByAutoId().setValue(elaborateResponse)
                }
                self.loadWeighInResults()
            })
        }
    }
}
