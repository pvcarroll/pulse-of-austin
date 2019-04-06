//
//  TopicModel.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 2/16/19.
//  Copyright © 2019 Paul Carroll. All rights reserved.
//

import Foundation

struct TopicData {
    let topicKey: String
    let title: String
    let readUpLabel: String
    let visualizeLabel: String
    let viewpointsLabel: String
    let milestonesLabel: String
    let dateUpdated: String
    let infoSlides: [String]
    let weighInPrompt: String
    let weighInChoices: [String]
}

struct Viewpoint: Hashable {
    let text: String
    let latitude: Double
    let longitude: Double
    let date: String
}
