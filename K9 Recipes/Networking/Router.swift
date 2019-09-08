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
    case getIngredients
    case getFilteredByIngredients
    case getRecipeDetails
    case getCategories
    case getRecipesByCategory
    
    var path: String {
        let prefix = "\(Constants.apiPathPrefix)/\(Constants.apiKey)"
        
        switch self {
        case .getLatestRecipes:
            return "\(prefix)/latest.php"
        case .getIngredients:
            return "\(prefix)/list.php"
        case .getFilteredByIngredients:
            return "\(prefix)/filter.php"
        case .getRecipeDetails:
            return "\(prefix)/lookup.php"
        case .getCategories:
            return "\(prefix)/categories.php"
        case .getRecipesByCategory:
            return "\(prefix)/filter.php"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getLatestRecipes,
             .getFilteredByIngredients,
             .getRecipeDetails,
             .getCategories,
            .getRecipesByCategory:
            return []
        case .getIngredients:
            return [
                URLQueryItem(name: "i", value: "list")
            ]
        }
    }
    
    var method: String {
        switch self {
        case .getLatestRecipes,
             .getIngredients,
             .getFilteredByIngredients,
             .getRecipeDetails,
             .getCategories,
            .getRecipesByCategory:
            return "GET"
        }
    }
}
