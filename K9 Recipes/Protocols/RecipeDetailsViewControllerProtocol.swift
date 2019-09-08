//
//  RecipeDetailsViewControllerProtocol.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

protocol RecipeDetailsViewControllerProtocol: class {
    // MARK: - Props
    var recipe: Recipe? { get }
    var isPerformingRefresh: Bool { get }
    var hasContent: Bool { get }
    
    // MARK: - Requests
    func getDetails(recipeId: String?)
    
    // MARK: - Observers
    func onChange(_ completion: ((RecipeDetailsChange) -> Void)?)
}

enum RecipeDetailsChange {
    case startedLoading
    case finishedLoading(Result<Recipe?, Error>)
}
