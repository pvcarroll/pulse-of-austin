//
//  ExploreViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/14/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit
import FirebaseAuth

class ExploreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var latestLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var selectedTopicKey: String?
    private var exploreTopics = [ExploreTopic]()
    
    //
    // MARK: Lifecycle Methods
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gearIcon"), style: .plain, target: self, action: nil)
        
        HTTPRequests.fetchExploreTopics { (exploreTopics) in
            self.exploreTopics = exploreTopics
            self.tableView.reloadData()
        }
        // Set profile tab bar item title with logged in user's name
        if let uid = Auth.auth().currentUser?.uid {
            HTTPRequests.getUserName(uid: uid) { (name) in
                self.tabBarController?.tabBar.items?[2].title = name
            }
        }

        self.latestLabel.textColor = UIColor.darkGray74
        tableView.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "topicCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 140
        self.tableView.tableFooterView = UIView()
    }

    //
    // MARK:- UITableViewDataSource
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exploreTopics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as? TopicCell
        guard let topicCell = cell else { return UITableViewCell() }
        let exploreTopic: ExploreTopic = exploreTopics[indexPath.row]
        topicCell.titleLabel.text = exploreTopic.title
        topicCell.descriptionLabel.text = exploreTopic.desc
        topicCell.dateUpdated.text = exploreTopic.dateUpdated
        return topicCell
    }
    
    //
    // MARK:- UITableViewDelegate
    //
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedTopicKey = exploreTopics[indexPath.row].topicKey
        self.performSegue(withIdentifier: "toTopicInfo", sender: self)
    }
    
    // MARK:- Prepare for Segue
    
    internal override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? TopicInfoViewController)?.topicKey = self.selectedTopicKey
    }
}
