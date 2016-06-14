//
//  ProfileTableViewController.swift
//  MyGithub
//
//  Created by David Nadri on 6/9/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfileTableViewController: UITableViewController {
    
    var profile = Profile?()
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var menuBarButton: UIBarButtonItem!

    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var repositoriesLabel: UILabel!
    
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ProfileTableViewController: viewDidLoad() called.")
        
        getProfileInfo()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderWidth = 4.0
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        
        //tableView.tableFooterView = UIView(frame: CGRectZero)
        
        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Uncomment to change the width of the side menu
        //self.revealViewController().rearViewRevealWidth = 100
        
    }
    
    func getProfileInfo() {
        
        //Alamofire.Manager.sharedInstance.session.configuration.requestCachePolicy = .ReturnCacheDataElseLoad
        
        Alamofire.request(.GET, "https://api.github.com/users/wework-test").validate(statusCode: 200..<300).responseJSON { response in
            
            //let cachedURLResponse = NSCachedURLResponse(response: response.response!, data: response.data!, userInfo: nil, storagePolicy: .Allowed)
            //NSURLCache.sharedURLCache().storeCachedResponse(cachedURLResponse, forRequest: response.request!)
            
            if response.result.value != nil {
                
                let json = JSON(response.result.value!)
                print("json: \(json)")
                
                let avatarURL = json["avatar_url"].URL
                print("avatar_url: \(avatarURL)")
                
                let name = json["name"].string
                print("name: \(name)")
                
                let login = json["login"].string
                print("login: \(login)")
                
                let followers = json["followers"].int
                print("followers: \(followers)")
                
                let repositories = json["public_repos"].int
                print("repositories: \(repositories)")
                
                let following = json["following"].int
                print("following: \(following)")
            
                let bio = json["bio"].string
                print("bio: \(bio)")
                
                self.profile = Profile(avatarURL: avatarURL!, name: name!, username: login!, followers: followers!, repositories: repositories!, following: following!, bio: bio!)
                
                self.setOutlets()
                
            } else {
                
                print("ERROR: \(response.result.error)")
                let alert = UIAlertController(title: "Error", message: "\(response.result.error)", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                alert.presentViewController(alert, animated: true, completion: nil)
                
            }
        }
        
    }
    
    func setOutlets() {
        
        if let avatar = self.profile?.avatarURL {
            
            // Asynchronously load the user's avatar from the url retrieved from the API call
            dispatch_async(dispatch_get_main_queue(), {
                
                self.profileImageView.image =  UIImage(data: NSData(contentsOfURL: avatar)!)
                self.backgroundImageView.image = self.profileImageView.image
            })
        }
        
        if let name = self.profile?.name {
            self.userLabel.text = name
        }
        
        if let username = self.profile?.login {
            self.usernameLabel.text = username
        }
        
        if let followers = self.profile?.followers {
            self.followersLabel.text = String(followers)
        }
        
        if let repositories = self.profile?.repositories {
            self.repositoriesLabel.text = String(repositories)
        }
        
        if let following = self.profile?.following {
            self.followingLabel.text = String(following)
        }
        
        if let bio = self.profile?.bio {
            self.bioLabel.text = bio
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

