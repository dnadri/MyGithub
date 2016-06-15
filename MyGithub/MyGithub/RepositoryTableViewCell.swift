//
//  RepositoryTableViewCell.swift
//  MyGithub
//
//  Created by David Nadri on 6/10/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var repositoryNameLabel: UILabel!
    
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    
    @IBOutlet weak var stargazersCountLabel: UILabel!
    
    @IBOutlet weak var forksCountLabel: UILabel!
    
    @IBOutlet weak var issuesCountLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
}
