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
        0: Topic(topicKey: "docklessBikeshare",
                 title: "DOCKLESS BIKESHARE",
                 description: "What privatized operations mean for your data",
                 topicIntroData: TopicIntroData(topicTitle: "Dockless Bikeshare",
                                                cardTitle: "PILOT KICKOFF",
                                                cardBodyText: buildBodyText(),
                                                promptText: "WHAT COULD THIS MEAN FOR RIDERSHIP DATA?"),
                 topicInfoTitle: "Dockless Bikeshare",
                 learnText: LearnText(overviewText: [],
                                      breakdownTitle: "",
                                      breakdownAmountsText: [],
                                      breakdownDescriptionsText: [],
                                      onTheBallotTitle: "",
                                      onTheBallotAmountsText: [],
                                      onTheBallotDescriptionsText: [],
                                      perspectivesTitles: [],
                                      perspectivesText: []),
                 weighIn: WeighInSelectText(choices: ["", "", "Other"])),
        1: Topic(topicKey: "affordableHousingBond",
                 title: "AFFORDABLE HOUSING BOND",
                 description: "$161M vs. $300M: Council yet to decide",
                 topicIntroData: TopicIntroData(topicTitle: "Affordable Housing",
                                                cardTitle: "",
                                                cardBodyText: buildBodyText(),
                                                promptText: ""),
                 topicInfoTitle: "Affordable Housing Bond",
                 learnText: LearnText(overviewText: ["The cost of closing Austin’s Affordable Housing Gap today is around $6.48 Billion (48,000 unit gap).",
                                                     "The cost of closing Austin’s Affordable Housing Gap in 2025 is projected to be $11.18 Billion.",
                                                     "$161M: 1,900 units\n$300M: 7,000+ units"],
                                      breakdownTitle: "BOND BREAKDOWN",
                                      breakdownAmountsText: ["47%", "31%", "11%", "11%"],
                                      breakdownDescriptionsText: ["Rental Housing Development Assistance Projects",
                                                                  "Land Acquisition",
                                                                  "Acquisition and Development",
                                                                  "Home Repair Program"],
                                      onTheBallotTitle: "ON THE BALLOT",
                                      onTheBallotAmountsText: ["$112M", "$117M", "$179M", "$281M"],
                                      onTheBallotDescriptionsText: ["Stormwater (drainage and dams)",
                                                                    "Parkland and Open Space (water quality protection + new parkland)",
                                                                    "Transportation Infrastructure (bridges + street reconstruction)",
                                                                    "Facilities & Assets (Fire Dept., EMS, arts & culture centers, parks & rec, libraries, public health)"],
                                      perspectivesTitles: ["Housing Committee:", "Council Member Casar:"],
                                      perspectivesText: ["Fearing residents would reject a larger bond, suggest a $161 million bond focusing on lack of affordability all over town, especially west of I-35",
                                                         "Austin needs to make a significant investment in building new affordable housing, we should be bold by careful.  I support a $300 million bond."]),
                 weighIn: WeighInSelectText(choices: ["$300 Million", "$161 Million", "Other Thoughts"])),
        2: Topic(topicKey: "hollyPowerPlant",
                 title: "HOLLY POWER PLANT",
                 description: "City seeking input on park transformation",
                 topicIntroData: TopicIntroData(topicTitle: "Holly Power Plant",
                                                cardTitle: "",
                                                cardBodyText: buildBodyText(),
                                                promptText: ""),
                 topicInfoTitle: "Holly Power Plant",
                 learnText: LearnText(overviewText: [],
                                      breakdownTitle: "",
                                      breakdownAmountsText: [],
                                      breakdownDescriptionsText: [],
                                      onTheBallotTitle: "",
                                      onTheBallotAmountsText: [],
                                      onTheBallotDescriptionsText: [],
                                      perspectivesTitles: [],
                                      perspectivesText: []),
                 weighIn: WeighInSelectText(choices: ["", "", "Other"])),
        3: Topic(topicKey: "strategicMobilityPlan",
                 title: "STRATEGIC MOBILITY PLAN",
                 description: "Prioritize roads, public transit, or a balance?",
                 topicIntroData: TopicIntroData(topicTitle: "Strategic Mobility Plan",
                                                cardTitle: "",
                                                cardBodyText: buildBodyText(),
                                                promptText: ""),
                 topicInfoTitle: "Strategic Mobility Plan",
                 learnText: LearnText(overviewText: [],
                                      breakdownTitle: "",
                                      breakdownAmountsText: [],
                                      breakdownDescriptionsText: [],
                                      onTheBallotTitle: "",
                                      onTheBallotAmountsText: [],
                                      onTheBallotDescriptionsText: [],
                                      perspectivesTitles: [],
                                      perspectivesText: []),
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
    let topicKey: String
    let title: String
    let description: String
    let topicIntroData: TopicIntroData
    let topicInfoTitle: String
    let learnText: LearnText
    let weighIn: WeighInSelectText
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

struct LearnText {
    let overviewText: [String]
    let breakdownTitle: String
    let breakdownAmountsText: [String]
    let breakdownDescriptionsText: [String]
    let onTheBallotTitle: String
    let onTheBallotAmountsText: [String]
    let onTheBallotDescriptionsText: [String]
    let perspectivesTitles: [String]
    let perspectivesText: [String]
}

// MARK:- Weigh In Flow Data Model
struct WeighInSelectText {
    let choices: [String]
}
