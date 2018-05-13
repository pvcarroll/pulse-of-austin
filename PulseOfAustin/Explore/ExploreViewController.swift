//
//  ExploreViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/14/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var exploreScreenTitle: UILabel!
    @IBOutlet var latestLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    //
    // MARK: Lifecycle Methods
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.exploreScreenTitle.textColor = UIColor.customDarkText
        self.exploreScreenTitle.font = UIFont.screenTitle
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
    // MARK:- UITableViewDataSource
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TopicData.topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as? TopicCell
        guard let topicCell = cell else { return UITableViewCell() }
//            topicCell.textLabel?.text = topics[indexPath.row].title
//            topicCell.detailTextLabel?.text = topics[indexPath.row].description
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
        self.performSegue(withIdentifier: "toTopicIntro", sender: self)
    }
}


