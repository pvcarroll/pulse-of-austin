//
//  ExploreViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/14/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var latestLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var selectedTopicKey = -1
    
    //
    // MARK: Lifecycle Methods
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gearIcon"), style: .plain, target: self, action: nil)
        
        self.latestLabel.textColor = UIColor.darkGray74
        
        tableView.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "topicCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140
        self.tableView.tableFooterView = UIView()
    }

    //
    // MARK:- UITableViewDataSource
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TopicData.topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as? TopicCell
        guard let topicCell = cell else { return UITableViewCell() }
        topicCell.titleLabel.text = TopicData.topics[indexPath.row]?.title
        topicCell.titleLabel.font = UIFont.cardTitle
        topicCell.descriptionLabel.text = TopicData.topics[indexPath.row]?.description
        return topicCell
    }
    
    //
    // MARK:- UITableViewDelegate
    //
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedTopicKey = indexPath.row
        self.performSegue(withIdentifier: "toTopicInfo", sender: self)
    }
    
    // MARK:- Prepare for Segue
    
    internal override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? TopicInfoViewController)?.selectedTopicKey = self.selectedTopicKey
    }
}
