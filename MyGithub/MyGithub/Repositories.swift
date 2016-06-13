//
//  Repositories.swift
//  MyGithub
//
//  Created by David Nadri on 6/12/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Repository {
    
    var id: String?
    var name: String?
    var description: String?
    var ownerLogin: String?
    var url: String?
    
    required init(json: JSON) {
        
        self.id = json["id"].string
        self.name = json["name"].string
        self.description = json["description"].string
        self.ownerLogin = json["owner"]["login"].string
        self.url = json["url"].string
        
    }
    
    class func getRepos() {

        
        // https://github.com/Alamofire/Alamofire#usage
        Alamofire.request(.GET, "https://api.github.com/users/dnadri/repos").responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
        }
        
    }
    

}