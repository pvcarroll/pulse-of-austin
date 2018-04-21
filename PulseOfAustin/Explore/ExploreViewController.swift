//
//  ExploreViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/14/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

struct Topic {
    var title: String
    var description: String
}

class ExploreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let topics = [
        Topic(title: "DOCKLESS BIKESHARE", description: "What privatized operations mean for your data"),
        Topic(title: "AFFORDABLE HOUSING BOND", description: "$161M vs. $300M: Council yet to decide"),
        Topic(title: "HOLLY POWER PLANT", description: "City seeking input on park transformation"),
        Topic(title: "STRATEGIC MOBILITY PLAN", description: "Prioritize roads, public transit, or a balance?")
    ]
    
    @IBOutlet var exploreLabel: UILabel!
    @IBOutlet var latestLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    //
    // MARK: Lifecycle Methods
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.exploreLabel.textColor = UIColor.customDarkText
        self.latestLabel.textColor = UIColor.customDarkText
        
        tableView.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "topicCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //
    // MARK: UITableViewDataSource
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as? TopicCell
        guard let topicCell = cell else { return UITableViewCell() }
//            topicCell.textLabel?.text = topics[indexPath.row].title
//            topicCell.detailTextLabel?.text = topics[indexPath.row].description
        topicCell.titleLabel.text = topics[indexPath.row].title
        topicCell.descriptionLabel.text = topics[indexPath.row].description
        return topicCell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toTopicIntro", sender: self)
    }
}
