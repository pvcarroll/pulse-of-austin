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
    
    var topicKey: String?
    private var topicData: TopicData?
    private var cardIndex = 0
    private var selectedAnswer: AnswerIndex?
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
        
        if let userID = Auth.auth().currentUser?.uid
            , let topicKey = topicData?.topicKey {
            HTTPRequests.checkIfTopicAnswered(userID: userID, topicKey: topicKey) { (answered) in
                if answered {
                    self.loadWeighInResults(alreadyAnswered: true)
                } else {
                    self.loadWeighInSelect()
                }
            }
        } else {
            self.loadWeighInSelect()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.backgroundColor = UIColor.infoCardBackground
        
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
        
        HTTPRequests.fetchTopicData(topicKey: self.topicKey!) { (topicData) in
            self.title = topicData.title
            self.topicData = topicData
            self.loadLearnLanding()
        }
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
    // MARK:- Learn Flow
    //
    
    // Learn Screen 1: Landing
    private func loadLearnLanding() {
        if let landingView = UINib(nibName: "LearnLanding", bundle: nil)
                            .instantiate(withOwner: self, options: nil).first as! LearnLanding? {
            landingView.frame = self.topicInfoViewContainer.bounds
            landingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            landingView.readUpLabel.text = self.topicData?.readUpLabel
            landingView.readUpDateLabel.text = self.topicData?.dateUpdated
            landingView.mapLabel.text = self.topicData?.visualizeLabel
            landingView.mapDateLabel.text = self.topicData?.dateUpdated
            landingView.viewpointsLabel.text = self.topicData?.viewpointsLabel
            landingView.viewpointsDateLabel.text = self.topicData?.dateUpdated
            landingView.milestonesLabel.text = self.topicData?.milestonesLabel
            landingView.milestonesDateLabel.text = self.topicData?.dateUpdated
            let scrollViewHeight = landingView.stackView.frame.height + landingView.milestoneView.frame.height + 40
            landingView.contentSize = CGSize(width: landingView.frame.width,
                                             height: scrollViewHeight)
            let infoRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.loadLearnCards))
            landingView.readUpCell.addGestureRecognizer(infoRecognizer)
            let mapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.loadLearnMap))
            landingView.mapCell.addGestureRecognizer(mapRecognizer)
            self.updateViewContent(newView: landingView)
            landingView.viewpointsCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.loadViewpoints)))
        }
    }
    
    // Learn Screen 2: Learn Scroll View
    @objc private func loadLearnCards() {
        guard let learnCardFrame = self.cardFrame else { return }
        guard let cardsContainer = UINib(nibName: "LearnCardsContainer", bundle: nil)
            .instantiate(withOwner: self, options: nil).first as! LearnCardsContainer? else { return }
        cardsContainer.frame = self.topicInfoViewContainer.bounds
        let cardsScrollView = cardsContainer.scrollView
        cardsScrollView?.contentSize.height = 1.0
        
        // Insert card content for each slide into HTML template
        var htmlSlides = [String]()
        let htmlTemplate = HTMLStrings.htmlTemplate
        for cardContent in topicData?.infoSlides ?? [] {
            htmlSlides.append(htmlTemplate.replacingOccurrences(of: "#HTML_CONTENT#", with: cardContent))
        }

        // Create cards and add to scroll view
        for i in 0..<htmlSlides.count {
            guard let card = UINib(nibName: "LearnCard", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! LearnCard? else { return }
            
            let cardWidth = learnCardFrame.width
            card.frame = CGRect(origin: CGPoint(x: CGFloat(i) * cardWidth, y: 0),
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
    // MARK:- Weigh In Flow
    //
    
    // Weigh In Screen 1: Select
    private func loadWeighInSelect() {
        self.pageControl.numberOfPages = 3
        if let weighInSelectView = UINib(nibName: "WeighInSelect", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! WeighInSelect?
            , let weightInCardFrame = self.cardFrame {
            
            weighInSelectView.frame = weightInCardFrame
            
            weighInSelectView.prompt.text = topicData?.weighInPrompt
            
            weighInSelectView.answer1Button.setTitle(topicData?.weighInChoices[0], for: .normal)
            weighInSelectView.answer2Button.setTitle(topicData?.weighInChoices[1], for: .normal)
            weighInSelectView.answer3Button.setTitle(topicData?.weighInChoices[2], for: .normal)

            weighInSelectView.answer1Button.addTarget(self, action: #selector(self.answer1Selected), for: .touchUpInside)
            weighInSelectView.answer2Button.addTarget(self, action: #selector(self.answer2Selected), for: .touchUpInside)
            weighInSelectView.answer3Button.addTarget(self, action: #selector(self.answer3Selected), for: .touchUpInside)
            
            self.updateViewContent(newView: weighInSelectView)
        }
    }
    
    // Weigh In Screen 2: Elaborate
    private func loadWeighInElaborate(answerText: String, elaborateRequired: Bool = false) {
        self.pageControl.currentPage = 1
        if let elaborateView = UINib(nibName: "WeighInElaborate", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! WeighInElaborate?,
                let weightInCardFrame = self.cardFrame {
            self.elaborateView = elaborateView
            elaborateView.frame = weightInCardFrame
            var cardTitleText = "ELABORATE"
            if elaborateRequired {
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
    
    // Weigh In Screen 3: Results
    private func loadWeighInResults(alreadyAnswered: Bool = false) {
        self.pageControl.currentPage = 2
        if let resultsView = UINib(nibName: "WeighInResults", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! WeighInResults?
            , let weightInCardFrame = self.cardFrame {
            if !alreadyAnswered {
                resultsView.showInputWasSentToast()
            }
            resultsView.frame = weightInCardFrame
            
            resultsView.response4View.isHidden = (self.topicData?.weighInChoices.count == 3)
            
            resultsView.response1Label.text = self.topicData?.weighInChoices[0]
            resultsView.response2Label.text = self.topicData?.weighInChoices[1]

            if (self.topicData?.weighInChoices.count)! > 3 {
                resultsView.response3Label.text = self.topicData?.weighInChoices[2]
                resultsView.response4Label.text = "Other"
            } else {
                resultsView.response3Label.text = "Other"
            }
            
            // Set response bar lengths based on count
            if let topicKey = self.topicKey {
                HTTPRequests.getWeighInResponses(topicKey: topicKey) { values in
                    
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
                    
                    let count1 = answerChoice1 ?? 0
                    resultsView.response1Tallies.frame.size = CGSize(width: maxWidth * CGFloat(count1) / CGFloat(maxCount), height: talliesBarHeight)
                    resultsView.response1Count.text = String(count1)
                    let count2 = answerChoice2 ?? 0
                    resultsView.response2Tallies.frame.size = CGSize(width: maxWidth * CGFloat(count2) / CGFloat(maxCount), height: talliesBarHeight)
                    resultsView.response2Count.text = String(count2)
                    let count3 = answerChoice3 ?? 0
                    resultsView.response3Tallies.frame.size = CGSize(width: maxWidth * CGFloat(count3) / CGFloat(maxCount), height: talliesBarHeight)
                    resultsView.response3Count.text = String(count3)
                    let count4 = answerChoice4 ?? 0
                    resultsView.response4Tallies.frame.size = CGSize(width: maxWidth * CGFloat(count4) / CGFloat(maxCount), height: talliesBarHeight)
                    resultsView.response4Count.text = String(count4)
                }
            }
            self.updateViewContent(newView: resultsView)
        }
    }
    
    //
    // MARK:- Viewpoints
    //
    
    @objc private func loadViewpoints() {
        let maxNumberOfPerspectivesCards = 4
        let maxNumberOfViewpoints = maxNumberOfPerspectivesCards * 2
        guard let topicKey = self.topicKey else { return }
        HTTPRequests.getViewPointsForTopic(topicKey: topicKey) { (viewpoints) in
            let randomViewpoints: [Viewpoint]
            if viewpoints.count > maxNumberOfViewpoints {
                randomViewpoints = self.getRandomViewpoints(viewpoints: viewpoints, number: maxNumberOfViewpoints)
            } else {
                randomViewpoints = viewpoints
            }
            
            guard let cardFrame = self.cardFrame else { return }
            guard let cardsContainer = UINib(nibName: "LearnCardsContainer", bundle: nil)
                .instantiate(withOwner: self, options: nil).first as! LearnCardsContainer? else { return }
            
            cardsContainer.frame = self.topicInfoViewContainer.bounds
            let cardsScrollView = cardsContainer.scrollView
            cardsScrollView?.contentSize.height = 1.0

            let numberOfPerspectivesCards = min(maxNumberOfPerspectivesCards, Int(ceil(Double(viewpoints.count) / 2.0)))
            // Create cards and add to scroll view
            for i in 0..<numberOfPerspectivesCards {
                guard let card = UINib(nibName: "PerspectivesCard", bundle: nil)
                    .instantiate(withOwner: self, options: nil).first as! PerspectivesCard? else { return }

                let cardWidth = cardFrame.width
                card.frame = CGRect(origin: CGPoint(x: CGFloat(i) * cardWidth, y: 0),
                                    size: cardFrame.size)
                card.xButton.addTarget(self, action: #selector(TopicInfoViewController.learnCardXTapped), for: .touchDown)
                card.pageControl.numberOfPages = numberOfPerspectivesCards
                card.pageControl.currentPage = i
                // First card opaque, others translucent
                card.alpha = ((i == 0) ? 1.0 : 0.5)
                
                card.titleSummaryView.isHidden = (i != 0)
                
                // Set viewpoint text
                let viewpoint1Index = (i + 1) * 2 - 2
                let viewpoint2Index = (i + 1) * 2 - 1
                let viewpoint1 = randomViewpoints[viewpoint1Index]
                card.viewpoint1Label.text = viewpoint1.text
                card.viewpoint1ResponderLabel.text = self.coordinatesToRegion(latitude: viewpoint1.latitude,
                                                                              longitude: viewpoint1.longitude)
                card.viewpoint1DateLabel.text = viewpoint1.date
                
                if viewpoint2Index < viewpoints.count {
                    let viewpoint2 = randomViewpoints[viewpoint2Index]
                    card.viewpoint2Label.text = viewpoint2.text
                    card.viewpoint2ResponderLabel.text = self.coordinatesToRegion(latitude: viewpoint2.latitude,
                                                                                  longitude: viewpoint2.longitude)
                    card.viewpoint2DateLabel.text = viewpoint2.date
                } else {
                    card.viewpoint2Label.text = ""
                    card.viewpoint2ResponderLabel.text = ""
                    card.viewpoint2DateLabel.text = ""
                }

                cardsScrollView?.addSubview(card)
                cardsScrollView?.contentSize.width += card.frame.width
            }
            self.updateViewContent(newView: cardsContainer)
        }
    }
    
    private func coordinatesToRegion(latitude: Double, longitude: Double) -> String {
        let northLatitude = 30.379050
        let southLatitude = 30.247359
        let westLongitude = -97.756324
        let eastLongitude = -97.706909
        if latitude > northLatitude {
            if longitude < westLongitude {
                return "nw austinite"
            } else if longitude > eastLongitude {
                return "ne austinite"
            } else {
                return "north austinite"
            }
        } else if latitude < southLatitude {
            if longitude < westLongitude {
                return "sw austinite"
            } else if longitude > eastLongitude {
                return "se austinite"
            } else {
                return "south austinite"
            }
        } else {
            if longitude < westLongitude {
                return "west austinite"
            } else if longitude > eastLongitude {
                return "east austinite"
            } else {
                return "central austinite"
            }
        }
    }
    
    //
    // MARK:- Event Handlers
    //
    
    @objc func learnCardXTapped(sender: UIButton!) {
        self.loadLearnLanding()
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
        self.loadWeighInElaborate(answerText: answerText, elaborateRequired: answerText == "Other Thoughts")
    }
    @objc func submitWeighInTapped(recognizer: UITapGestureRecognizer) {
        guard let _ = Auth.auth().currentUser else {
            self.presentLogin()
            return
        }
        self.saveWeighInResponse()
    }
    
    //
    // MARK:- Private Methods
    //
    
    private func updateViewContent(newView: UIView) {
        self.topicInfoViewContainer.subviews.forEach { $0.removeFromSuperview() }
        self.topicInfoViewContainer.addSubview(newView)
    }
    
    private func getRandomViewpoints(viewpoints: [Viewpoint], number: Int) -> [Viewpoint] {
        var randomViewpoints = Set<Viewpoint>()
        while randomViewpoints.count < number {
            if let randomItem = viewpoints.randomElement() {
                randomViewpoints.insert(randomItem)
            }
        }
        return Array(randomViewpoints)
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
        if let topicKey = self.topicKey
            , let answer = self.selectedAnswer
            , let uid = Auth.auth().currentUser?.uid {
            let responseText = self.elaborateView?.response ?? ""

            let df = DateFormatter()
            df.dateFormat = "MM.dd.yy"
            let dateString = df.string(from: Date())
            
            let elaborateResponse = Viewpoint(text: responseText, latitude: 0, longitude: 0, date: dateString)
            HTTPRequests.saveWeighInResponse(uid: uid, topicKey: topicKey, answer: answer, elaborateResponse: elaborateResponse) {
                self.loadWeighInResults()
            }
        }
    }
}
