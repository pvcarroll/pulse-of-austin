//
//  NotificationsSettingsViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 9/13/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit
import FirebaseMessaging

class NotificationsSettingsViewController: UIViewController {

    @IBOutlet weak var notificationSetting1StackView: UIStackView!
    @IBOutlet weak var notificationSetting2StackView: UIStackView!
    @IBOutlet weak var notificationSetting3StackView: UIStackView!
    @IBOutlet weak var goldenCheck1: UIImageView!
    @IBOutlet weak var goldenCheck2: UIImageView!
    @IBOutlet weak var goldenCheck3: UIImageView!
    @IBOutlet weak var pulseChecksFromTheCityLabel: UILabel!
    
    private let goldenCheck = UIImage(named: "goldenCheck")
    
    private let latestHappeningsKey = "latestHappenings"
    private let myTopicsKey = "myTopics"
    private let pulseChecksKey = "pulseChecks"
    
    private var subscribeToLatestHappenings = true
    private var subscribeToMyTopics = true
    private var subscribeToPulseChecks = true
    
    @IBAction func doneTapped(_ sender: Any) {
        // Subscribe user to topics
        if self.subscribeToLatestHappenings {
            Messaging.messaging().subscribe(toTopic: self.latestHappeningsKey)
        } else {
            Messaging.messaging().unsubscribe(fromTopic: self.latestHappeningsKey)
        }
        if self.subscribeToMyTopics {
            Messaging.messaging().subscribe(toTopic: self.myTopicsKey)
        } else {
            Messaging.messaging().unsubscribe(fromTopic: self.myTopicsKey)
        }
        if self.subscribeToPulseChecks {
            Messaging.messaging().subscribe(toTopic: self.pulseChecksKey)
        } else {
            Messaging.messaging().unsubscribe(fromTopic: self.pulseChecksKey)
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let italicFont = UIFont.italicSystemFont(ofSize: 16)
        let regularFont = UIFont.systemFont(ofSize: 16)
        let pulseChecksString = NSMutableAttributedString(string: "Pulse Checks", attributes: [NSAttributedString.Key.font: italicFont])
        let fromTheCityString = NSAttributedString(string: " from the City", attributes: [NSAttributedString.Key.font: regularFont])
        pulseChecksString.append(fromTheCityString)
        self.pulseChecksFromTheCityLabel.attributedText = pulseChecksString
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(self.latestHappeningsAlertTapped))
        self.notificationSetting1StackView.addGestureRecognizer(tapGestureRecognizer1)
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(self.myTopicsAlertTapped))
        self.notificationSetting2StackView.addGestureRecognizer(tapGestureRecognizer2)
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(self.pulseChecksAlertTapped))
        self.notificationSetting3StackView.addGestureRecognizer(tapGestureRecognizer3)
    }
    
    //
    // MARK:- Private
    //
    
    @objc private func latestHappeningsAlertTapped() {
        self.subscribeToLatestHappenings = !self.subscribeToLatestHappenings
        self.goldenCheck1.image = (self.subscribeToLatestHappenings ? self.goldenCheck : nil)
    }
    @objc private func myTopicsAlertTapped() {
        self.subscribeToMyTopics = !self.subscribeToMyTopics
        self.goldenCheck2.image = (self.subscribeToMyTopics ? self.goldenCheck : nil)
    }
    @objc private func pulseChecksAlertTapped() {
        self.subscribeToPulseChecks = !self.subscribeToPulseChecks
        self.goldenCheck3.image = (self.subscribeToPulseChecks ? self.goldenCheck : nil)
    }
}
