//
//  IssuesTableViewController.swift
//  MyGithub
//
//  Created by David Nadri on 6/10/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import UIKit
import Alamofire

class IssuesTableViewController: UITableViewController {
    
    var issues = [Issue?]()
    
    // Note: repoName is used in RepositoriesTableViewConytoller's prepareForSegue:
    var repoName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("IssuesTableViewController: viewDidLoad() called.")
        
        getIssues()
        
        // Self-sizing cells (auto-layout constraints must be set for cell)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        // Removes extra cell separators below tableview (of empty/unused cells)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
    }
    
    func getIssues() {
        
        print("repoName: \(repoName!)")
        
        Alamofire.request(.GET, "https://api.github.com/repos/wework-test/\(repoName!)/issues?state=all").validate(statusCode: 200..<300).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let json = response.result.value {
                print("***json: \(json)")
                print("***json.count: \(json.count)")
                
                for item in json as! [AnyObject] {
                    print("item in JSON: \(item)")
                    
                    let issue = Issue(number: item["number"] as? Int, title: item["title"] as? String, body: item["body"] as? String, comments: item["comments"] as? Int, commentsURL: nil, timestamp: item["updated_at"] as? String, state: item["state"] as? String)
                    
                    self.issues.append(issue)
                    
        
                }
                
                self.tableView.reloadData()
        
            } else {
                
                print("ERROR: \(response.result.error)")
                let alert = UIAlertController(title: "Error", message: "\(response.result.error)", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                alert.presentViewController(alert, animated: true, completion: nil)
                
            }

        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.issues.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("IssueCell") as! IssuesTableViewCell

        if let number = self.issues[indexPath.row]?.number {
            cell.numberLabel.text = "#\(number)"
        }
        
        if let title = self.issues[indexPath.row]?.title {
            cell.titleLabel.text = title
        }
        
        // "Updated Jun 13, 2016, 6:26PM EDT"
        // i.e.: "Updated 4 days ago"
        if let dateUpdated = self.issues[indexPath.row]?.timestamp {
            let dateFormatter = NSDateFormatter()
            // The format must match the timestamp string otherwise it will return nil
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sszzz"
            let date = dateFormatter.dateFromString(dateUpdated)
            cell.timestampLabel.text = NSDate().offsetFrom(date!)
        }
        
        if let state = self.issues[indexPath.row]?.state {
            if state == "closed" {
                // Ideal to create constants for things like image names, but in the interest of time...
                cell.stateImageView.image = UIImage(named: "closed")
            } else {
                cell.stateImageView.image = UIImage(named: "opened")
            }
        }
        
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showNewIssueTableViewController" {
            
            print("prepareForSegue: showNewIssueTableViewController.")
            
            let nav = segue.destinationViewController as! UINavigationController
            
            let destinationVC = nav.topViewController as! NewIssueTableViewController
            
            // Pass the repoName to the NewIssueTableViewController
            destinationVC.currentRepoName = repoName
            
        }
        
        if segue.identifier == "showIssueDetailTableViewController" {
            
            print("prepareForSegue: showIssueDetailTableViewController.")
            
            let destinationVC = segue.destinationViewController as! IssueDetailTableViewController
            
            // Pass the issue to the IssueDetailTableViewController for use
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let issue = self.issues[indexPath.row]
                    
                destinationVC.issue = issue
                
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
