//
//  EditIssueTableViewController.swift
//  MyGithub
//
//  Created by David Nadri on 6/15/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditIssueTableViewController: UITableViewController, UITextViewDelegate {
    
    var repoName: String!
    
    var issue: Issue!
    
    var isOpen: Bool!
    
    var openIssueCell: UITableViewCell = UITableViewCell()
    
    var closeIssueCell: UITableViewCell = UITableViewCell()
    
    
    @IBOutlet weak var submitBarButton: UIBarButtonItem!
    
    @IBOutlet weak var titleTextView: UITextView!
    
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var issueStateCell: UITableViewCell!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        titleTextView.delegate = self
        //titleTextView.becomeFirstResponder()
        commentTextView.delegate = self
        
        // Assign the issue's title and body text to the respective textviews
        self.titleTextView.text = issue.title!
        self.commentTextView.text = issue.body!
        

        // Removes extra cell separators below tableview (of empty/unused cells)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // Conditionally draw/set the issue state tableview cell
        if indexPath.section == 2 {
            
            // Reopen Issue/Close Issue cell
            if issue.state! == "open" {
                print("ISSUE STATE CELL - 'Close Issue'")
                
                isOpen = true
                
                //Construct closeIssueCell
                cell.textLabel?.text = "Close Issue"
                cell.textLabel?.textAlignment = .Center
                cell.textLabel?.textColor = UIColor.githubRedColor()
                
            } else if issue.state! == "closed" {
                print("ISSUE STATE CELL - 'Reopen Issue'")
                
                isOpen = false
                
                // Construct openIssueCell
                cell.textLabel?.text = "Reopen Issue"
                cell.textLabel?.textAlignment = .Center
                cell.textLabel?.textColor = UIColor.githubGreenColor()
                
            }
            
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected cell #\(indexPath.row)")
        
        if indexPath.section == 2 {
            
            confirmEdit()
            
        }
        
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        
        self.view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func submitTapped(sender: AnyObject) {
        
        print("EditIssueTableViewController: submitTapped()")
        print("Original Issue: \(issue!)")
        print("repoName: \(repoName)")
        
        self.submitBarButton.enabled = false
        
        let headers = [
            "Authorization": Constants.token,
            "Accept": "application/json"
        ]
        
        let parameters = [
            "title": self.titleTextView.text,
            "body":  self.commentTextView.text
        ]
        
        Alamofire.request(.PATCH, "https://api.github.com/repos/wework-test/\(repoName)/issues/\(issue.number!)", parameters: parameters, encoding: .JSON, headers: headers).validate(statusCode: 200..<300).responseJSON { response in
            
            guard response.result.error ==  nil else {
                // ERROR
                print("ERROR: \(response.result.error!)")
                let alert = UIAlertController(title: "Error", message: "Whoops! Looks like there was an error while processing your request. Please try again later. (Code: \(response.result.error?.code))", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                alert.presentViewController(alert, animated: true, completion: nil)
                
                return
            }
            
            if let value = response.result.value {
                // SUCCESS
                let issue = JSON(value)
                print("SUCCESS: Edited Issue: \(issue.description)")
            }
            
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    func closeIssue() {
        print("closeIssue()")
        
        let headers = [
            "Authorization": Constants.token,
            "Accept": "application/vnd.github.v3+json"
        ]
        
        // Type: string	
        // Description: State of the issue. Either "open" or "closed".
        // In this car, state will be updated to "closed"
        let parameters = ["state": "closed"]
        
        Alamofire.request(.PATCH, "https://api.github.com/repos/wework-test/\(repoName)/issues/\(issue.number!)", parameters: parameters, encoding: .JSON, headers: headers).validate(statusCode: 200..<300).responseJSON { response in
            
            guard response.result.error ==  nil else {
                // ERROR
                print("ERROR: \(response.result.error!)")
                let alert = UIAlertController(title: "Error", message: "Whoops! Looks like there was an error while processing your request. Please try again later. (Code: \(response.result.error?.code))", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                alert.presentViewController(alert, animated: true, completion: nil)
                
                return
            }
            
            if let value = response.result.value {
                // SUCCESS
                let issue = JSON(value)
                print("SUCCESS: Edited Issue: \(issue.description)")
            }
            
        }
        
    }

    func openIssue() {
        print("openIssue()")
        
        let headers = [
            "Authorization": Constants.token,
            "Accept": "application/vnd.github.v3+json"
        ]
        
        // Type: string
        // Description: State of the issue. Either "open" or "closed".
        // In this car, state will be updated to "open"
        let parameters = ["state": "open"]
        
        Alamofire.request(.PATCH, "https://api.github.com/repos/wework-test/\(repoName)/issues/\(issue.number!)", parameters: parameters, encoding: .JSON, headers: headers).validate(statusCode: 200..<300).responseJSON { response in
            
            guard response.result.error ==  nil else {
                // ERROR
                print("ERROR: \(response.result.error!)")
                let alert = UIAlertController(title: "Error", message: "Whoops! Looks like there was an error while processing your request. Please try again later. (Code: \(response.result.error?.code))", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                alert.presentViewController(alert, animated: true, completion: nil)
                
                return
            }
            
            if let value = response.result.value {
                // SUCCESS
                let issue = JSON(value)
                print("SUCCESS: Edited Issue: \(issue.description)")
            }
            
        }
    
    }
    
    func confirmEdit() {
        print("confirmEdit() called.")
        
        // Create an option menu as an action sheet to confirm user's issue edit
        let optionMenu = UIAlertController(title: "Are you sure you want to change the state of this issue?", message: nil, preferredStyle: .ActionSheet)
        
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "No", style: .Cancel, handler: nil)
        
        let editAction = UIAlertAction(title: "Yes", style: .Default, handler: { action in

            // open/close issue here
            if self.isOpen == true {
                self.closeIssue()
            } else {
                self.openIssue()
            }
            
            self.dismissViewControllerAnimated(true, completion: nil)

        })
        
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(editAction)
        presentViewController(optionMenu, animated: true, completion: nil)
        
    }

}
