//
//  ProfileViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 9/1/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit
import FirebaseAuth
import MapKit

let councilMembers = [
    "01_OraHouston",
    "02_DeliaGarza",
    "03_SabinoRenteria",
    "04_GregorioCasar",
    "05_AnnKitchen",
    "06_JimmyFlannigan",
    "07_LesliePool",
    "08_EllenTroxclair",
    "09_KathieTovo",
    "10_AlisonAlter"
]

class ProfileViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pictureContainer: UIView!
    @IBOutlet weak var counselMemberPicture: UIImageView!
    @IBOutlet weak var councilMemberName: UILabel!
    @IBOutlet weak var pushNotificationsButton: UIButton!
    @IBOutlet weak var basicInfoButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    private var userData: UserData?
    private var homeAnnotation: MKPointAnnotation = MKPointAnnotation()
    private var homeAddress: String = "" {
        didSet {
            // Set pin location on map
            let geoCode = CLGeocoder()
            geoCode.geocodeAddressString(homeAddress) { (placemarks, error) in
                if let coordinate = placemarks?[0].location?.coordinate {
                    self.homeAnnotation.coordinate = coordinate
                    self.mapView.centerCoordinate = coordinate
                }
            }
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
            self.present(homeVC, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true

        // Map
        let center = CLLocationCoordinate2DMake(30.26, -97.7)
        let span = MKCoordinateSpanMake(0.2, 0.3)
        mapView.region = MKCoordinateRegionMake(center, span)
        
        // Address pin
        homeAnnotation.title = "Home Address"
        mapView.addAnnotation(homeAnnotation)
        
        // Add shadow around to council member picture
        pictureContainer.clipsToBounds = false
        pictureContainer.layer.cornerRadius = pictureContainer.frame.width
        pictureContainer.addBottomShadow(shadowColor: UIColor.black, shadowRadius: 4)
        pictureContainer.layer.shadowPath = UIBezierPath(roundedRect: pictureContainer.bounds, cornerRadius: pictureContainer.frame.width / 2).cgPath
        counselMemberPicture.layer.cornerRadius = counselMemberPicture.frame.width / 2
        counselMemberPicture.clipsToBounds = true
        counselMemberPicture.layer.masksToBounds = true
        
        // TODO: set council member picture
        let randomNumber = Int(arc4random_uniform(10))
        let image = UIImage(imageLiteralResourceName: councilMembers[randomNumber])
        counselMemberPicture.image = image
        
        // TODO: set council member
        councilMemberName.text = "PIO RENTERIA"
        
        let borderColor = UIColor(displayP3Red: 200/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1.0).cgColor
        
        pushNotificationsButton.layer.borderColor = borderColor
        pushNotificationsButton.layer.borderWidth = 1.0
        basicInfoButton.layer.borderColor = borderColor
        basicInfoButton.layer.borderWidth = 1.0
        logOutButton.layer.borderColor = borderColor
        logOutButton.layer.borderWidth = 1.0
        
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setScreenTitleWithUserName()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser?.email == nil {
            let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
            self.present(loginVC, animated: true) {
                loginVC.presentAlertModal(title: "", message: "You must logged in to view profile")
            }
            return
        }
    }
    
    //
    // MARK:- Private
    //
    
    private func setScreenTitleWithUserName() {
        // TODO: move db query
        if let email = Auth.auth().currentUser?.email,
            let dbRef = (UIApplication.shared.delegate as! AppDelegate).dbRef {
            dbRef.child("users")
                .queryOrdered(byChild: "email")
                .queryEqual(toValue: email)
                .observeSingleEvent(of: .value, with: { (snapshot) in
                    if let values = snapshot.value as? [String: Any], let userObject = values.first?.value as! [AnyHashable: Any]?, let userName = userObject["name"] as? String {
                        self.title = userName
                        if let address = userObject["address"] as? String {
                            self.homeAddress = address + ", Austin, TX, "
                            if let zipCode = userObject["zipCode"] as? String {
                                self.homeAddress += zipCode
                                // Save user data
                                if let email = userObject["email"] as? String {
                                    self.userData = UserData(address: address, zipCode: zipCode, email: email)
                                }
                            }
                        }
                    }
                })
        }
    }
    
    // MARK:- Prepare for Segue
    
    internal override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? BasicInfoViewController)?.userData = self.userData
    }
}

extension ProfileViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {return nil}
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
}

struct UserData {
    var address: String
    var zipCode: String
    var email: String
}
