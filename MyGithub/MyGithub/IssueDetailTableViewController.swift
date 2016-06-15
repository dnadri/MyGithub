//
//  IssueDetailTableViewController.swift
//  MyGithub
//
//  Created by David Nadri on 6/15/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import UIKit

class IssueDetailTableViewController: UITableViewController {

    var issue: Issue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("IssueDetailTableViewController: viewDidLoad() called.")
        
        
        // Self-sizing cells (auto-layout constraints must be set for cell)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        // Removes extra cell separators below tableview (of empty/unused cells)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("IssueDetailCell") as! IssueDetailTableViewCell
        
//        if let number = self.issues[indexPath.row]?.number {
//            cell.numberLabel.text = "#\(number)"
//        }
//        
//        if let title = self.issues[indexPath.row]?.title {
//            cell.titleLabel.text = title
//        }
//        
//        // "Updated Jun 13, 2016, 6:26PM EDT"
//        // i.e.: "Updated 4 days ago"
//        if let dateUpdated = self.issues[indexPath.row]?.timestamp {
//            let dateFormatter = NSDateFormatter()
//            // The format must match the timestamp string otherwise it will return nil
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sszzz"
//            let date = dateFormatter.dateFromString(dateUpdated)
//            cell.timestampLabel.text = NSDate().offsetFrom(date!)
//        }
//        
//        if let state = self.issues[indexPath.row]?.state {
//            if state == "closed" {
//                // Ideal to create constants for things like image names, but in the interest of time...
//                cell.stateImageView.image = UIImage(named: "closed")
//            } else {
//                cell.stateImageView.image = UIImage(named: "opened")
//            }
//        }
        
        
        return cell
    }
    
    
}
