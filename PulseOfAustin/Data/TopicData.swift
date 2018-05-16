//
//  TopicData.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 5/12/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

enum TopicData {
    static let topics: [Int: Topic] = [
        0: Topic(title: "DOCKLESS BIKESHARE",
                 description: "What privatized operations mean for your data",
                 topicIntroData: TopicIntroData(topicTitle: "Dockless Bikeshare",
                                                cardTitle: "PILOT KICKOFF",
                                                cardBodyText: buildBodyText(),
                                                promptText: "WHAT COULD THIS MEAN FOR RIDERSHIP DATA?"),
                 topicInfoTitle: "Dockless Bikeshare",
                 weighIn: WeighInSelectText(choices: ["", "", "Other"])),
        1: Topic(title: "AFFORDABLE HOUSING BOND",
                 description: "$161M vs. $300M: Council yet to decide",
                 topicIntroData: TopicIntroData(topicTitle: "Affordable Housing",
                                                cardTitle: "",
                                                cardBodyText: buildBodyText(),
                                                promptText: ""),
                 topicInfoTitle: "Affordable Housing Bond",
                 weighIn: WeighInSelectText(choices: ["$300 Million", "$161 Million", "Other Thoughts"])),
        2: Topic(title: "HOLLY POWER PLANT",
                 description: "City seeking input on park transformation",
                 topicIntroData: TopicIntroData(topicTitle: "Holly Power Plant",
                                                cardTitle: "",
                                                cardBodyText: buildBodyText(),
                                                promptText: ""),
                 topicInfoTitle: "Holly Power Plant",
                 weighIn: WeighInSelectText(choices: ["", "", "Other"])),
        3: Topic(title: "STRATEGIC MOBILITY PLAN",
                 description: "Prioritize roads, public transit, or a balance?",
                 topicIntroData: TopicIntroData(topicTitle: "Strategic Mobility Plan",
                                                cardTitle: "",
                                                cardBodyText: buildBodyText(),
                                                promptText: ""),
                 topicInfoTitle: "Strategic Mobility Plan",
                 weighIn: WeighInSelectText(choices: ["", "", "Other"]))
    ]
    
    private static func buildBodyText() -> NSMutableAttributedString {
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

struct Topic {
    var title: String
    var description: String
    var topicIntroData: TopicIntroData
    var topicInfoTitle: String
    var weighIn: WeighInSelectText
}

struct TopicIntroData {
    let topicTitle: String
    let cardTitle: String
    let cardBodyText: NSAttributedString
    let promptText: String
}

// MARK:- Learn Flow Data Model
struct TopicInfoText {
    let overviewP1: String
    let overviewP2: String
    let overviewP3: String
    let infoScreen2Title: String
    let infoScreen2Body: String
    let onTheBallotBody: String
}

// MARK:- Weigh In Flow Data Model
struct WeighInSelectText {
    let choices: [String]
}
