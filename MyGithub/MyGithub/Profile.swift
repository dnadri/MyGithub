//
//  Profile.swift
//  MyGithub
//
//  Created by David Nadri on 6/13/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import Foundation

class Profile {
    
    var avatarURL: NSURL
    var name: String?
    var login: String?
    var followers: Int?
    var repositories: Int?
    var following: Int?
    var bio: String?
    
    init(avatarURL: NSURL, name: String?, username: String?, followers: Int?, repositories: Int?, following: Int?, bio: String?) {
        
        self.avatarURL = avatarURL
        self.name = name
        self.login = username
        self.followers = followers
        self.repositories = repositories
        self.following = following
        self.bio = bio

    }
    
}
