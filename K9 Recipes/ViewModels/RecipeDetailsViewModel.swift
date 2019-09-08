//
//  RecipeDetailsViewModel.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import Foundation

class RecipeDetailsViewModel: RecipeDetailsViewControllerProtocol {
    var recipe: Recipe?
    
    var isPerformingRefresh: Bool = false
    
    var hasContent: Bool {
        return recipe != nil
    }
    
    private var changeClosure: ((RecipeDetailsChange) -> Void)?
    private let lock = NSLock()
    
    func getDetails(recipeId: String?) {
        guard let recipeId = recipeId else { return }
        isPerformingRefresh = true
        fetchDetails(recipeId: recipeId)
    }
    
    private func fetchDetails(recipeId: String) {
        lock.lock(); defer { lock.unlock() }
        changeClosure?(.startedLoading)
        
        let param = URLQueryItem(name: "i", value: "\(recipeId)")
        
        ServiceLayer.request(router: Router.getRecipeDetails, params: [param]) { [weak self] (result: Result<[String: [Recipe]], Error>) in
            switch result {
            case let .success(res):
                let recipes = res["meals"] ?? []
                self?.recipe = recipes.first
                self?.changeClosure?(.finishedLoading(.success(recipes.first)))
            case let .failure(error):
                Logger.log(message: "Failed to fetch latest recipes", type: .error)
                self?.changeClosure?(.finishedLoading(.failure(error)))
            }
        }
    }
    
    func onChange(_ completion: ((RecipeDetailsChange) -> Void)?) {
        changeClosure = completion
    }
    
}
