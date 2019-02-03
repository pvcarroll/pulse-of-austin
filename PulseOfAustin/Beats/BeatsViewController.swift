//
//  BeatsViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 11/24/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class BeatsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "topicCell")
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension BeatsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // + 1 for header that scrolls with table view
        return BeatsData.beats.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let screenWidth = UIScreen.main.bounds.width
            let headerViewHeight: CGFloat = 43.5
            let headerViewFrame = CGRect(x: 0, y: 0, width: screenWidth, height: headerViewHeight)
            let headerCell = UITableViewCell(frame: headerViewFrame)
            let headerLabel = UILabel(frame: CGRect(x: 16, y: 0, width: screenWidth - 16, height: headerViewHeight))
            headerLabel.font = UIFont.futuraMedium20
            headerLabel.text = "LATEST UPDATES"
            headerCell.addSubview(headerLabel)
            headerCell.selectionStyle = .none
            return headerCell
        }
        let beatsIndex = indexPath.row - 1
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as? TopicCell
        guard let topicCell = cell else { return UITableViewCell() }
        topicCell.titleLabel.text = BeatsData.beats[beatsIndex].title
        topicCell.descriptionLabel.text = BeatsData.beats[beatsIndex].description
        topicCell.dateUpdated.text = BeatsData.beats[beatsIndex].dateAdded
        return topicCell
    }
}

extension BeatsViewController: UITableViewDelegate {
    
}
