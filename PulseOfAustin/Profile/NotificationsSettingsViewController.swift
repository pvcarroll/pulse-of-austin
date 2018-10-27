//
//  NotificationsSettingsViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 9/13/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class NotificationsSettingsViewController: UIViewController {

    @IBOutlet weak var notificationSetting1StackView: UIStackView!
    @IBOutlet weak var notificationSetting2StackView: UIStackView!
    @IBOutlet weak var notificationSetting3StackView: UIStackView!
    @IBOutlet weak var goldenCheck1: UIImageView!
    @IBOutlet weak var goldenCheck2: UIImageView!
    @IBOutlet weak var goldenCheck3: UIImageView!
    @IBOutlet weak var pulseChecksFromTheCityLabel: UILabel!
    
    let goldenCheck = UIImage(named: "goldenCheck")
    
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
        if self.goldenCheck1.image == nil {
            self.goldenCheck1.image = self.goldenCheck
        } else {
            self.goldenCheck1.image = nil
        }
    }
    @objc private func myTopicsAlertTapped() {
        if self.goldenCheck2.image == nil {
            self.goldenCheck2.image = self.goldenCheck
        } else {
            self.goldenCheck2.image = nil
        }
    }
    @objc private func pulseChecksAlertTapped() {
        if self.goldenCheck3.image == nil {
            self.goldenCheck3.image = self.goldenCheck
        } else {
            self.goldenCheck3.image = nil
        }
    }
}
