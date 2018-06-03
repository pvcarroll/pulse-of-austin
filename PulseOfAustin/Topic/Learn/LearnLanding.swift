//
//  LearnLanding.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/2/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class LearnLanding: UIScrollView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topicsTableView: UITableView!
    @IBOutlet weak var milestoneView: UIView!
    @IBOutlet weak var milestonesLabel: UILabel!
    @IBOutlet weak var crestImage1: UIImageView!
    @IBOutlet weak var crestImage2: UIImageView!
    @IBOutlet weak var crestImage3: UIImageView!
    @IBOutlet weak var scopeLabel: UILabel!
    @IBOutlet weak var draftLabel: UILabel!
    @IBOutlet weak var actLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.infoCardBackground
        self.topicsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.topicsTableView.tableFooterView = UITableView()
        self.topicsTableView.dataSource = self
        self.topicsTableView.delegate = self
        
        self.milestonesLabel.font = UIFont.introCardBodyBold
        self.crestImage1.backgroundColor = UIColor.infoCardBackground
        self.crestImage2.backgroundColor = UIColor.infoCardBackground
        self.crestImage3.backgroundColor = UIColor.infoCardBackground
        let crestImageBackgroundCornerRadius = self.crestImage1.frame.height / 2
        self.crestImage1.layer.cornerRadius = crestImageBackgroundCornerRadius
        self.crestImage2.layer.cornerRadius = crestImageBackgroundCornerRadius
        self.crestImage3.layer.cornerRadius = crestImageBackgroundCornerRadius
        self.crestImage1.addBottomShadow(shadowColor: UIColor.black, shadowRadius: 4)
        self.crestImage2.addBottomShadow(shadowColor: UIColor.black, shadowRadius: 4)
        self.crestImage3.addBottomShadow(shadowColor: UIColor.black, shadowRadius: 4)
        
        self.scopeLabel.backgroundColor = UIColor.customYellow
        self.draftLabel.backgroundColor = UIColor.customYellow
        self.actLabel.backgroundColor = UIColor.customYellow
        let milestoneStageCornerRadius = self.scopeLabel.frame.height / 2
        self.scopeLabel.layer.cornerRadius = milestoneStageCornerRadius
        self.draftLabel.layer.cornerRadius = milestoneStageCornerRadius
        self.actLabel.layer.cornerRadius = milestoneStageCornerRadius
        self.scopeLabel.layer.masksToBounds = true
        self.draftLabel.layer.masksToBounds = true
        self.actLabel.layer.masksToBounds = true
        self.scopeLabel.textColor = UIColor.whiteText
        self.draftLabel.textColor = UIColor.whiteText
        self.actLabel.textColor = UIColor.whiteText
    }
    
    //
    // MARK:- UITableViewDataSource
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isContentCell = (indexPath.row % 2 == 0)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        switch indexPath.row {
        case let row where row % 2 == 1:
            // Spacer cell
            cell.isUserInteractionEnabled = false
            cell.textLabel?.text = ""
            cell.contentView.backgroundColor = UIColor.infoCardBackground
        case 0:
            cell.textLabel?.text = "BOND BREAKDOWN AND POTENTIAL IMPACT"
        case 2:
            cell.textLabel?.text = "MAP: CITY'S LAND ACQUISITION PLANS"
        case 4:
            cell.textLabel?.text = "PERSPECTIVES"
        default:
            cell.textLabel?.text = ""
        }
        if isContentCell { // not spacer cell
            cell.textLabel?.font = UIFont.introCardBodyBold
            cell.textLabel?.numberOfLines = 0
            cell.addBottomShadow()
//            let imageView = UIImageView(image: )
        }
        return cell
    }
    
    //
    // MARK:- UITableViewDelegate
    //
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case let row where row % 2 == 1:
            return 10
        default:
            return 80
        }
    }
}
