//
//  Repository.swift
//  MyGithub
//
//  Created by David Nadri on 6/13/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Repository {
    
    var name: String?
    var description: String?
    var stargazersCount: Int?
    var forksCount: Int?
    var issuesCount: Int?
    var timestamp: String?
    
    init(name: String?, description: String?, stargazersCount: Int?, forksCount: Int?, issuesCount: Int?, timestamp: String?) {
        
        self.name = name
        self.description = description
        self.stargazersCount = stargazersCount
        self.forksCount = forksCount
        self.issuesCount = issuesCount
        self.timestamp = timestamp
        
    }
    
}