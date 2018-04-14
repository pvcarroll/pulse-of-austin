//
//  HomeViewController.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/9/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var exploreButton: UIButton!
    
    @IBAction func exploreTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toExplore", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exploreButton.layer.cornerRadius = self.exploreButton.frame.height / 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
