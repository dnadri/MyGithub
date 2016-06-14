//
//  RepositoriesTableViewController.swift
//  MyGithub
//
//  Created by David Nadri on 6/10/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RepositoriesTableViewController: UITableViewController {
    
    var repositories = [Repository?]()
    
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRepositories()
        
        // Self-sizing cells (auto-layout constraints must be set for cell)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Removes extra cell separators below tableview (of empty/unused cells)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Uncomment to change the width of the side menu
        //self.revealViewController().rearViewRevealWidth = 62
        
    }
    
    func getRepositories() {
        
        Alamofire.request(.GET, "https://api.github.com/users/wework-test/repos").validate(statusCode: 200..<300).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let json = response.result.value {
                print("***json: \(json)")
                print("***json.count: \(json.count)")

                //self.repositories = JSON as! [Repository]
                for item in json as! NSMutableArray {
                    print("item in JSON: \(item)")
                    
//                    let name = item["name"] as! String
//                    print("name: \(name)")
//                    
//                    let description = item["description"] as! String
//                    print("description: \(description)")
//                    
//                    let stargazersCount = item["stargazers_count"] as! Int
//                    print("stargazersCount: \(stargazersCount)")
//                    
//                    let forksCount = item["forks_count"] as! Int
//                    print("forksCount: \(forksCount)")
//                    
//                    let issuesCount = item["open_issues_count"] as! Int
//                    print("issuesCount: \(issuesCount)")
//                    
//                    let timestamp = item["updated_at"] as! String
//                    print("timestamp: \(timestamp)")
                    
                    let repository = Repository(name: item["name"] as? String, description: item["description"] as? String, stargazersCount: item["stargazers_count"] as? Int, forksCount: item["forks_count"] as? Int, issuesCount: item["open_issues_count"] as? Int, timestamp: item["updated_at"] as? String)
                    
                    self.repositories.append(repository)
                    
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
        
        return self.repositories.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("RepositoryCell", forIndexPath: indexPath) as! RepositoryTableViewCell
        
//        cell.repositoryNameLabel.text = self.repositories[indexPath.row]?.name
//        cell.repositoryDescriptionLabel.text = self.repositories[indexPath.row]?.description
//        cell.stargazersCountLabel.text = self.repositories[indexPath.row]?.stargazersCount
//        cell.forksCountLabel.text = self.repositories[indexPath.row]?.forksCount
//        cell.issuesCountLabel.text = self.repositories[indexPath.row]?.issuesCount
        
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
