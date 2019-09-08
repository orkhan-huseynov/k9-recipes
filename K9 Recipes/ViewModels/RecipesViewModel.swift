//
//  RecipesViewModel.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import Foundation

class RecipesViewModel: RecipesViewControllerProtocol {
    var recipes = [Recipe]()
    
    var isPerformingRefresh: Bool = false
    
    var hasContent: Bool {
        return !recipes.isEmpty
    }
    
    private var changeClosure: ((RecipesChange) -> Void)?
    private let lock = NSLock()
    
    func loadList(category: Category?) {
        guard let category = category else { return }
        
        isPerformingRefresh = true
        fetchList(category: category)
    }
    
    private func fetchList(category: Category) {
        lock.lock(); defer { lock.unlock() }
        changeClosure?(.startedLoading)
        
        let param = URLQueryItem(name: "c", value: category.name)
        
        ServiceLayer.request(router: .getRecipesByCategory, params: [param]) { [weak self] (result: Result<[String: [Recipe]], Error>) in
            switch result {
            case let .success(res):
                let recipes = res["meals"] ?? []
                self?.recipes = recipes
                self?.changeClosure?(.finishedLoading(.success(recipes)))
            case let .failure(error):
                Logger.log(message: "Failed to fetch category recipes", type: .error)
                self?.changeClosure?(.finishedLoading(.failure(error)))
            }
        }
    }
    
    func onChange(_ completion: ((RecipesChange) -> Void)?) {
        changeClosure = completion
    }
    
}

