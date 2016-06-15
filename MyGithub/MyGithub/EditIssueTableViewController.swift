//
//  EditIssueTableViewController.swift
//  MyGithub
//
//  Created by David Nadri on 6/15/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import UIKit

class EditIssueTableViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Removes extra cell separators below tableview (of empty/unused cells)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
    }
    
    
    @IBAction func cancelTapped(sender: AnyObject) {
        
        self.view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func submitTapped(sender: AnyObject) {
        print("EditIssueTableViewController: submitTapped()")
        
        
        
    }
    

}
