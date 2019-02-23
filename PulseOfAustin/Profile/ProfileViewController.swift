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

let councilMemberNames = [
    "Ora Houston",
    "Delia Garza",
    "Sabino Renteria",
    "Gregorio Casar",
    "Ann Kitchen",
    "Jimmy Flannigan",
    "Leslie Pool",
    "Ellen Troxclair",
    "Kathie Tovo",
    "Alison Alter"
]
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
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pictureContainer: UIView!
    @IBOutlet weak var councilMemberPicture: UIImageView!
    @IBOutlet weak var councilMemberName: UILabel!
    @IBOutlet weak var pushNotificationsButton: UIButton!
    @IBOutlet weak var basicInfoButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    private var requiresLogin = false
    private var visitedBasicInfo = false
    private var userData: UserData? {
        didSet {
            guard let councilDistrict = self.userData?.councilDistrict else { return }
            self.districtLabel.text = "District \(councilDistrict)"
            self.councilMemberName.text = councilMemberNames[councilDistrict - 1]
            self.councilMemberPicture.image = UIImage(imageLiteralResourceName: councilMembers[councilDistrict - 1])
            self.addCouncilDistrictOverlay(councilDistrict: councilDistrict)
        }
    }
    private var homeAnnotation: MKPointAnnotation = MKPointAnnotation()
    private var homeAddress: String = "" {
        didSet {
            // Set home address pin on map
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
        let span = MKCoordinateSpan.init(latitudeDelta: 0.2, longitudeDelta: 0.3)
        mapView.region = MKCoordinateRegion.init(center: center, span: span)
        
        // Address pin
        homeAnnotation.title = "Home Address"
        mapView.addAnnotation(homeAnnotation)
        
        // Add shadow around to council member picture
        pictureContainer.clipsToBounds = false
        pictureContainer.layer.cornerRadius = pictureContainer.frame.width
        pictureContainer.addBottomShadow(shadowColor: UIColor.black, shadowRadius: 4)
        pictureContainer.layer.shadowPath = UIBezierPath(roundedRect: pictureContainer.bounds, cornerRadius: pictureContainer.frame.width / 2).cgPath
        councilMemberPicture.layer.cornerRadius = councilMemberPicture.frame.width / 2
        councilMemberPicture.clipsToBounds = true
        councilMemberPicture.layer.masksToBounds = true
        
        let borderColor = UIColor(displayP3Red: 200/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1.0).cgColor
        
        pushNotificationsButton.layer.borderColor = borderColor
        pushNotificationsButton.layer.borderWidth = 1.0
        basicInfoButton.layer.borderColor = borderColor
        basicInfoButton.layer.borderWidth = 1.0
        logOutButton.layer.borderColor = borderColor
        logOutButton.layer.borderWidth = 1.0
        
        self.mapView.delegate = self
        self.fetchUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if visitedBasicInfo {
            fetchUserInfo()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.requiresLogin {
            // Last time viewDidAppear ran, the user wasn't logged in, so user info wasn't fetched
            self.fetchUserInfo()
        }
        if Auth.auth().currentUser?.email == nil {
            self.requiresLogin = true
            let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
            self.present(loginVC, animated: true) {
                loginVC.presentAlertModal(title: "", message: "You must logged in to view profile")
            }
            return
        } else {
            self.requiresLogin = false
        }
    }
    
    //
    // MARK:- Private
    //
    
    private func addCouncilDistrictOverlay(councilDistrict: Int) {
        let districtBounds = formatDistrictPoints(councilDistrict: councilDistrict)
        mapView.removeOverlays(mapView.overlays)
        districtBounds.forEach { pointsSet in
            let points = pointsSet
            let polygon = MKPolygon(coordinates: points, count: points.count)
            self.mapView.addOverlay(polygon)
        }
    }
    
    private func fetchUserInfo() {
        if let uid = Auth.auth().currentUser?.uid {
            HTTPRequests.getUserInfo(uid: uid) { (values) in
                if let email = values[AppConstants.email] as? String
                    , let userName = values[AppConstants.name] as? String
                    , let address = values[AppConstants.address] as? String
                    , let zipCode = values[AppConstants.zipCode] as? String
                    , let councilDistrict = values[AppConstants.councilDistrict] as? Int {
                    self.title = userName
                    self.homeAddress = "\(address), Austin, TX \(zipCode)"
                    self.userData = UserData(userID: uid, address: address, zipCode: zipCode, email: email, councilDistrict: councilDistrict)
                }
            }
        }
    }
    
    // MARK:- Prepare for Segue
    
    internal override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BasicInfoViewController {
            destination.userData = self.userData
            visitedBasicInfo = true
        } else {
            visitedBasicInfo = false
        }
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolygon {
            let polygonRenderer = MKPolygonRenderer(overlay: overlay)
            polygonRenderer.fillColor = UIColor(red:0.97, green:0.70, blue:0.07, alpha:0.4)
            polygonRenderer.lineWidth = 0
            return polygonRenderer
        }
        return MKPolygonRenderer(overlay: overlay as! MKPolygon)
    }
}

struct UserData {
    var userID: String
    var address: String
    var zipCode: String
    var email: String
    var councilDistrict: Int
}
