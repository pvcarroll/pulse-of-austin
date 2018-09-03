//
//  ProfileViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 9/1/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit
import MapKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pictureContainer: UIView!
    @IBOutlet weak var counselMemberPicture: UIImageView!
    @IBOutlet weak var councilMemberName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = CLLocationCoordinate2DMake(30.26, -97.7)
        let span = MKCoordinateSpanMake(0.2, 0.3)
        mapView.region = MKCoordinateRegionMake(center, span)
        
        // Add shadow around to counsel member picture
        pictureContainer.clipsToBounds = false
        pictureContainer.layer.cornerRadius = pictureContainer.frame.width
        pictureContainer.addBottomShadow(shadowColor: UIColor.black, shadowRadius: 4)
        pictureContainer.layer.shadowPath = UIBezierPath(roundedRect: pictureContainer.bounds, cornerRadius: pictureContainer.frame.width / 2).cgPath
        counselMemberPicture.layer.cornerRadius = counselMemberPicture.frame.width / 2
        counselMemberPicture.clipsToBounds = true
        counselMemberPicture.layer.masksToBounds = true
        counselMemberPicture.image = #imageLiteral(resourceName: "02_DeliaGarza")
        
        councilMemberName.text = "PIO RENTERIA"
    }
    
}
