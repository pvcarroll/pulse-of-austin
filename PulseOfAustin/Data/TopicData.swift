//
//  TopicData.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 5/12/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import Foundation

enum TopicData {
    static let topics: [Int: Topic] = [
        0: Topic(title: "DOCKLESS BIKESHARE", description: "What privatized operations mean for your data"),
        1: Topic(title: "AFFORDABLE HOUSING BOND", description: "$161M vs. $300M: Council yet to decide"),
        2: Topic(title: "HOLLY POWER PLANT", description: "City seeking input on park transformation"),
        3: Topic(title: "STRATEGIC MOBILITY PLAN", description: "Prioritize roads, public transit, or a balance?")
    ]
}

struct Topic {
    var title: String
    var description: String
}
