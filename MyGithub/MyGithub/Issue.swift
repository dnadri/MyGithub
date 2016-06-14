//
//  Issue.swift
//  MyGithub
//
//  Created by David Nadri on 6/13/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import Foundation

class Issue {
    
    var number: Int?
    var title: String?
    var body: String?
    var comments: Int?
    var timestamp: String?
    var state: String?
    
    init(number: Int?, title: String?, body: String?, comments: Int?, timestamp: String?, state: String?) {
        
        self.number = number
        self.title = title
        self.body = body
        self.comments = comments
        self.timestamp = timestamp
        self.state = state
        
    }
    
}