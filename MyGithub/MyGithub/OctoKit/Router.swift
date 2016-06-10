//
//  Router.swift
//  MyGithub
//
//  Created by David Nadri on 6/10/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import Foundation
import RequestKit

enum MyRouter: Router {
    
    case GetMyself(Configuration)
    
    var configuration: Configuration {
        switch self {
        case .GetMyself(let config): return config
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .GetMyself:
            return .GET
        }
    }
    
    var encoding: HTTPEncoding {
        switch self {
        case .GetMyself:
            return .URL
        }
    }
    
    var path: String {
        switch self {
        case .GetMyself:
            return "myself"
        }
    }
    
    var params: [String: AnyObject] {
        switch self {
        case .GetMyself(_):
            return ["key1": "value1", "key2": "value2"]
        }
    }
    
}