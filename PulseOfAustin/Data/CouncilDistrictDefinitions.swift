//
//  CouncilDistrictDefinitions.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 10/12/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import Foundation
import CoreLocation


func formatDistrictPoints(councilDistrict: Int) -> [[CLLocationCoordinate2D]] {
    var arrayOfCoordinateArrays: [[CLLocationCoordinate2D]] = []
    let districtBounds = getDistrictBounds(councilDistrict: councilDistrict)
    
    districtBounds.forEach { polygon in
        let points = polygon.split { $0 == "," }
        let coordinatesArray: [CLLocationCoordinate2D] = points.map { pointString in
            let pointArray = pointString.split(separator: " ")
            let longitude = Double(pointArray[0])!
            let latitude = Double(pointArray[1])!
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//            print("CLLocationCoordinate2D(latitude: \(latitude), longitude: \(longitude)),")
            return coordinate
        }
        arrayOfCoordinateArrays.append(coordinatesArray)
    }
    return arrayOfCoordinateArrays
}

private func getDistrictBounds(councilDistrict: Int) -> [String] {
    switch councilDistrict {
    case 1: return district1
    case 2: return district2
    case 3: return district3
    case 4: return district4
    case 5: return district5
    case 6: return district6
    case 7: return district7
    case 8: return district8
    case 9: return district9
    case 10: return district10
    default: return [""]
    }
}
