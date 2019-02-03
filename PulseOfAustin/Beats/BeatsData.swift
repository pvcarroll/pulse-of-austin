//
//  BeatsData.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 2/2/19.
//  Copyright © 2019 Paul Carroll. All rights reserved.
//

import Foundation

class BeatsData {
    static let beats: [Beat] = [
        Beat(title: "POLL RESULT: HOLLY POWER PLANT", description: "57% of respondents voted to prioritize playground space for the plant redesign. ", dateAdded: "9.9.18"),
        Beat(title: "AFFORDABLE HOUSING BOND APPROVED", description: "Council voted and approved a bond of $3.5 million to build new affordable housing units in central Austin for 2019.", dateAdded: "9.9.18"),
        Beat(title: "PLAZA SALTILLO", description: "The new development and metro hub in East Austin opens on Friday 9.13.18", dateAdded: "9.9.18"),
        Beat(title: "PIO RENTERIA", description: "Meet your representative.", dateAdded: "9.9.18")
    ]
}

struct Beat {
    let title: String
    let description: String
    let dateAdded: String
}
