//
//  Networking.swift
//  MyGithub
//
//  Created by David Nadri on 6/12/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//
//  https://github.com/Alamofire/Alamofire#usage


import Foundation
import Alamofire
import SwiftyJSON

class Networking {
    
    class func getProfileInfo(avatarURL: NSURL, name: String, username: String, followers: Int, starred: Int, following: Int, bio: String) {
        
        Alamofire.request(.GET, "https://api.github.com/users/wework-test").responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print("json: \(json)")
                
                if let photo = json["avatar_url"].URL {
                    
                    print("avatar_url")
                    
                }
                
                if let login = json["login"].string {
                    
                    print("login: \(login)")
                    
                } else {
                    print("error parsing...")
                }
            }
        }
        
    }
    
    class func getRepositories() {
        
        Alamofire.request(.GET, "https://api.github.com/users/wework-test/repos").responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print("json: \(json)")
                
                if let name = json["name"].string {
                    
                    print("name: \(name)")
                    
                } else {
                    print("error parsing...")
                }
            }
        }
        
    }
    
    class func getIssues() {
        
        Alamofire.request(.GET, "https://api.github.com/repos/wework-test/welkio-example/issues").responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print("json: \(json)")
                
                if let title = json["title"].string {
                    
                    print("title: \(title)")
                    
                } else {
                    print("error parsing...")
                }
            }
        }
        
    }
    
    
}
