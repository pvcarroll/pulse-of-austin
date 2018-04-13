//
//  ViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/9/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var exploreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exploreButton.layer.cornerRadius = self.exploreButton.frame.height / 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

