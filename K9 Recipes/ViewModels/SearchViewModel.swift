//
//  SearchViewModel.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import Foundation

class SearchViewModel: SearchViewControllerProtocol {
    var ingredients = [Ingredient]()
    
    var isPerformingRefresh: Bool = false
    
    var hasContent: Bool {
        return !ingredients.isEmpty
    }
    
    private var changeClosure: ((SearchChange) -> Void)?
    private let lock = NSLock()
    
    func loadIngredients() {
        isPerformingRefresh = true
        fetchIngredients()
    }
    
    private func fetchIngredients() {
        lock.lock(); defer { lock.unlock() }
        changeClosure?(.startedLoadingIngredients)
        
        ServiceLayer.request(router: Router.getIngredients) { [weak self] (result: Result<[String: [Ingredient]], Error>) in
            switch result {
            case let .success(res):
                let ingredients = res["meals"] ?? []
                self?.ingredients = ingredients
                self?.changeClosure?(.finishedLoadingIngredients(.success(ingredients)))
            case let .failure(error):
                Logger.log(message: "Failed to fetch ingredients", type: .error)
                self?.changeClosure?(.finishedLoadingIngredients(.failure(error)))
            }
        }
    }
    
    func onChange(_ completion: ((SearchChange) -> Void)?) {
        changeClosure = completion
    }
    
}
