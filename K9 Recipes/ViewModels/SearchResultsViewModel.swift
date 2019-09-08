//
//  SearchResultsViewModel.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import Foundation

class SearchResultsViewModel: SearchResultsViewControllerProtocol {
    var recipes = [Recipe]()
    
    var isPerformingRefresh: Bool = false
    
    var hasContent: Bool {
        return !recipes.isEmpty
    }
    
    private var changeClosure: ((SearchResultsChange) -> Void)?
    private let lock = NSLock()
    
    func loadList(query: String?) {
        guard let query = query else { return }
        
        isPerformingRefresh = true
        fetchList(query: query)
    }
    
    private func fetchList(query: String) {
        lock.lock(); defer { lock.unlock() }
        changeClosure?(.startedLoading)
        
        let param = URLQueryItem(name: "i", value: query)
        
        ServiceLayer.request(router: Router.getFilteredByIngredients, params: [param]) { [weak self] (result: Result<[String: [Recipe]], Error>) in
            switch result {
            case let .success(res):
                let recipes = res["meals"] ?? []
                self?.recipes = recipes
                self?.changeClosure?(.finishedLoading(.success(recipes)))
            case let .failure(error):
                Logger.log(message: "Failed to fetch search results", type: .error)
                self?.changeClosure?(.finishedLoading(.failure(error)))
            }
        }
    }
    
    func onChange(_ completion: ((SearchResultsChange) -> Void)?) {
        changeClosure = completion
    }
    
}

