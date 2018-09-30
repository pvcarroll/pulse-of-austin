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
                 topicInfoTitle: "Dockless Bikeshare",
                 learnText: LearnText(landingInfoLabel: "Learn about dockless bikeshare",
                                      landingMapLabel: "Dockless Bikeshare Map",
                                      overviewText: [],
                                      breakdownTitle: "What this could mean for ridership data?",
                                      breakdownAmountsText: [""],
                                      breakdownDescriptionsText: ["Data from dockless bikes could help the city prioritize bike infrastructure, but a lot of dockless bike companies will not make this data open."],
                                      onTheBallotTitle: "",
                                      onTheBallotAmountsText: [],
                                      onTheBallotDescriptionsText: [],
                                      perspectivesTitles: [],
                                      perspectivesText: []),
                 weighIn: WeighInSelectText(choices: ["", "", "Other"]),
                 dateUpdated: "9.9.18"
        ),
        1: Topic(topicKey: "affordableHousingBond",
                 title: "AFFORDABLE HOUSING BOND",
                 description: "$161M vs. $300M: Council yet to decide",
                 topicInfoTitle: "Affordability Bond",
                 learnText: LearnText(landingInfoLabel: "BOND BREAKDOWN AND POTENTIAL IMPACT",
                                      landingMapLabel: "MAP: CITY'S LAND ACQUISITION PLANS",
                                      overviewText: ["The cost of closing Austin’s Affordable Housing Gap today is around $6.48 Billion (48,000 unit gap).",
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
                 weighIn: WeighInSelectText(choices: ["$300 Million", "$161 Million", "Other Thoughts"]),
                 dateUpdated: "9.9.18"
        ),
        2: Topic(topicKey: "hollyPowerPlant",
                 title: "HOLLY POWER PLANT",
                 description: "City seeking input on park transformation",
                 topicInfoTitle: "Holly Power Plant",
                 learnText: LearnText(landingInfoLabel: "Learn about Holly power plant",
                                      landingMapLabel: "Holly Power Plant Map",
                                      overviewText: [],
                                      breakdownTitle: "",
                                      breakdownAmountsText: [],
                                      breakdownDescriptionsText: [],
                                      onTheBallotTitle: "",
                                      onTheBallotAmountsText: [],
                                      onTheBallotDescriptionsText: [],
                                      perspectivesTitles: [],
                                      perspectivesText: []),
                 weighIn: WeighInSelectText(choices: ["", "", "Other"]),
                 dateUpdated: "9.9.18"
        ),
        3: Topic(topicKey: "strategicMobilityPlan",
                 title: "STRATEGIC MOBILITY PLAN",
                 description: "Prioritize roads, public transit, or a balance?",
                 topicInfoTitle: "Strategic Mobility Plan",
                 learnText: LearnText(landingInfoLabel: "Learn about strategic mobility plan",
                                      landingMapLabel: "Strategic mobility plan map",
                                      overviewText: [],
                                      breakdownTitle: "",
                                      breakdownAmountsText: [],
                                      breakdownDescriptionsText: [],
                                      onTheBallotTitle: "",
                                      onTheBallotAmountsText: [],
                                      onTheBallotDescriptionsText: [],
                                      perspectivesTitles: [],
                                      perspectivesText: []),
                 weighIn: WeighInSelectText(choices: ["", "", "Other"]),
                 dateUpdated: "9.9.18"
        )
    ]
}

struct Topic {
    let topicKey: String
    let title: String
    let description: String
    let topicInfoTitle: String
    let learnText: LearnText
    let weighIn: WeighInSelectText
    let dateUpdated: String
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
    let landingInfoLabel: String
    let landingMapLabel: String
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
