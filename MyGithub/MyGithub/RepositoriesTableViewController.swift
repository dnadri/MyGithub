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
            
            if let JSON = response.result.value {
                print("***json: \(JSON)")
                print("***json.count: \(JSON.count)")

                //self.repositories = JSON as! [Repository]
                for item in JSON as! NSMutableArray {
                    print("item in JSON: \(item)")
                    
                    let name = item["name"] as! String
                    print("name: \(name)")
                    
                    let description = item["description"] as! String
                    print("description: \(description)")
                    
                    let stargazersCount = item["stargazers_count"] as! Int
                    print("stargazersCount: \(stargazersCount)")
                    
                    let forksCount = item["forks_count"] as! Int
                    print("forksCount: \(forksCount)")
                    
                    let issuesCount = item["open_issues_count"] as! Int
                    print("issuesCount: \(issuesCount)")
                    
                    let timestamp = item["updated_at"] as! String
                    print("timestamp: \(timestamp)")
                    
                    let repository = Repository(name: name, description: description, stargazersCount: stargazersCount, forksCount: forksCount, issuesCount: issuesCount, timestamp: timestamp)
                    
                    self.repositories.append(repository)
                    
                }
                
            } else {
                
                print("ERROR: \(response.result.error)")
                
            }
            
            self.tableView.reloadData()
            
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
        
//        if let name = self.repositories. {
//            cell.repositoryNameLabel.text = name
//        }
//        
//        if let description = self.repository?.description {
//            cell.repositoryDescriptionLabel.text = description
//        }
//        
//        if let stargazersCount = self.repository?.stargazersCount {
//            cell.stargazersCountLabel.text = String(stargazersCount)
//        }
//        
//        if let forksCount = self.repository?.forksCount {
//            cell.forksCountLabel.text = String(forksCount)
//        }
//        
//        if let issuesCount = self.repository?.issuesCount {
//            cell.issuesCountLabel.text = String(issuesCount)
//        }
//        
//        if let timestamp = self.repository?.timestamp {
//            cell.timestampLabel.text = timestamp
//        }
        
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
