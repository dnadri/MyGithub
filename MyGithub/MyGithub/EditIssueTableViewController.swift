//
//  EditIssueTableViewController.swift
//  MyGithub
//
//  Created by David Nadri on 6/15/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import UIKit
import Alamofire

class EditIssueTableViewController: UITableViewController, UITextViewDelegate {
    
    var openIssueCell: UITableViewCell = UITableViewCell()
    
    var closeIssueCell: UITableViewCell = UITableViewCell()
    
    @IBOutlet weak var titleTextView: UITextView!
    
    @IBOutlet weak var commentTextView: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        titleTextView.delegate = self
        titleTextView.becomeFirstResponder()
        commentTextView.delegate = self
        
        // Removes extra cell separators below tableview (of empty/unused cells)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
    }
    
    override func loadView() {
        
        super.loadView()
        
        // Construct openIssueCell
        self.openIssueCell.textLabel?.text = "Open Issue"
        self.openIssueCell.textLabel?.textColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1)
        
        //Construct closeIssueCell
        self.closeIssueCell.textLabel?.text = "Close Issue"
        self.closeIssueCell.textLabel?.textColor = UIColor(red: 255/255, green: 42/255, blue: 52/255, alpha: 1)
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 2 {
            
            print("Open/Close Issue cell")
            
            // if issue is open, create and return Close Issue cell (Red RGB: 255, 42, 52)
            // return self.closeIssueCell
            
            // else, create and return Open Issue cell (Green RGB: 0, 255, 0)
            // return self.openIssueCell
            
        }

        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 2 {
            
            // Open/Close the issue accordingly
            
        }
        
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        
        self.view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func submitTapped(sender: AnyObject) {
        print("EditIssueTableViewController: submitTapped()")
        
        
        
    }
    
    func closeIssue() {
        print("closeIssue()")
        
        let params = ["state": "closed"]
        
        Alamofire.request(.POST, "https://api.github.com/repos/wework-test/\(currentRepoName!)/issues/\(issueNumber)", parameters: params, encoding: .JSON)
            .validate(statusCode: 200..<300).responseJSON { response in
                
                guard response.result.error ==  nil else {
                    // ERROR
                    print("ERROR: \(response.result.error!)")
                    return
                }
                
                if let value = response.result.value {
                    // SUCCESS
                    let issue = JSON(value)
                    print("Closed Issue: \(issue.description)")
                }
                
        }
        
    }
    
    func openIssue() {
        print("openIssue()")
        
        let params = ["state": "open"]
        
        Alamofire.request(.POST, "https://api.github.com/repos/wework-test/\(currentRepoName!)/issues/\(issueNumber)", parameters: params, encoding: .JSON)
            .validate(statusCode: 200..<300).responseJSON { response in
                
                guard response.result.error ==  nil else {
                    // ERROR
                    print("ERROR: \(response.result.error!)")
                    return
                }
                
                if let value = response.result.value {
                    // SUCCESS
                    let issue = JSON(value)
                    print("Closed Issue: \(issue.description)")
                }
                
        }
        
    }
    
    }
    
}
