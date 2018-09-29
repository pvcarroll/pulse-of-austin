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
        let span = MKCoordinateSpan.init(latitudeDelta: 0.2, longitudeDelta: 0.3)
        mapView.region = MKCoordinateRegion.init(center: center, span: span)
        
        // home base
        let homeBaseCoordinates = CLLocationCoordinate2DMake(30.398599, -97.722067)
        let homeBaseAnnotation = MKPointAnnotation()
        homeBaseAnnotation.coordinate = homeBaseCoordinates
        homeBaseAnnotation.title = "Home Base"
        homeBaseAnnotation.subtitle = "subtitle"
        
        mapView.addAnnotation(homeBaseAnnotation)
    }
}

extension LearnMap: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("ANNOTATION SELECTED: \(view.annotation?.title)")
    }
}
