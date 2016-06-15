//
//  AboutTableViewController.swift
//  MyGithub
//
//  Created by David Nadri on 6/15/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Uncomment to change the width of the side menu
        //self.revealViewController().rearViewRevealWidth = 62
        
    }
    
}
