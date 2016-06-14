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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Self-sizing cells (auto-layout constraints must be set for cell)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Removes extra cell separators below tableview (of empty/unused cells)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
    }
    
    func getIssues() {
        
        Alamofire.request(.GET, "https://api.github.com/repos/wework-test/welkio-example/issues").validate(statusCode: 200..<300).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let json = response.result.value {
                print("***json: \(json)")
                print("***json.count: \(json.count)")
                
                for item in json as! NSMutableArray {
                    print("item in JSON: \(item)")
                    
                    let issue = Issue(number: item["number"] as? Int, title: item["title"] as? String, body: item["body"] as? String, comments: item["comments"] as? Int, timestamp: item["updated_at"] as? String, state: item["state"] as? String)
                    
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
        
        cell.numberLabel.text = String(self.issues[indexPath.row]?.number)
        cell.numberLabel.text = String(self.issues[indexPath.row]?.number)
        cell.titleLabel.text = String(self.issues[indexPath.row]?.title)
        cell.timestampLabel.text = String(self.issues[indexPath.row]?.timestamp)
        
        //if state == open
            //cell.stateImageView.image = UIImage(named: "open")
        
        
//        let dateUpdated = self.issues[indexPath.row]?.timestamp as NSDate
//        let dateFormat = NSDateFormatter()
//        dateFormat.dateFormat = "h:mm a"
//        cell.timestampLabel.text = NSString(format: "%@", dateFormat.stringFromDate(dateUpdated)) as String
        
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
