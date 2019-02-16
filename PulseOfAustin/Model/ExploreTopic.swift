//
//  ExploreTopic.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 2/16/19.
//  Copyright © 2019 Paul Carroll. All rights reserved.
//

import Foundation

struct ExploreTopic {
    let title: String
    let desc: String
    let dateUpdated: String
    
    static func convertDataToExploreTopic(exploreTopicData: NSDictionary) -> ExploreTopic {
        return ExploreTopic(title: exploreTopicData["title"] as? String ?? "",
                            desc: exploreTopicData["desc"] as? String ?? "",
                            dateUpdated: exploreTopicData["dateUpdated"] as? String ?? "")
    }
}
