//
//  TopicCell.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/15/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {
    
    @IBOutlet weak var topicCellBackgroundView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.topicCellBackgroundView.addBottomShadow()
        self.titleLabel.textColor = UIColor.darkGray74
        self.descriptionLabel.textColor = UIColor.darkGray74
    }
}
