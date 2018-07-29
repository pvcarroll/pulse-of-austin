//
//  LearnMap.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 7/29/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit
import MapKit

class LearnMap: UIView {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mapView.showsUserLocation = true
        
        let center = CLLocationCoordinate2DMake(30.26, -97.7)
        let span = MKCoordinateSpanMake(0.2, 0.3)
        mapView.region = MKCoordinateRegionMake(center, span)
    }
}
