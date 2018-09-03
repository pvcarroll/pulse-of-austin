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
    @IBOutlet weak var pushNotificationsButton: UIButton!
    @IBOutlet weak var basicInfoButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
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
        
        // TODO: set council member
        councilMemberName.text = "PIO RENTERIA"
        
        let borderColor = UIColor(displayP3Red: 200/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1.0).cgColor
        
        pushNotificationsButton.layer.borderColor = borderColor
        pushNotificationsButton.layer.borderWidth = 1.0
        basicInfoButton.layer.borderColor = borderColor
        basicInfoButton.layer.borderWidth = 1.0
        logOutButton.layer.borderColor = borderColor
        logOutButton.layer.borderWidth = 1.0
    }
    
}
