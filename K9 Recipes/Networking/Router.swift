//
//  Router.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import Foundation

enum Router {
    case getLatestRecipes
    
    var path: String {
        switch self {
        case .getLatestRecipes:
            return "\(Constants.apiPathPrefix)/\(Constants.apiKey)/latest.php"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getLatestRecipes:
            return []
        }
    }
    
    var method: String {
        switch self {
        case .getLatestRecipes:
            return "GET"
        }
    }
}
