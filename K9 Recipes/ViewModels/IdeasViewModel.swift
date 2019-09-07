//
//  IdeasViewModel.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import Foundation

class IdeasViewModel: IdeasViewControllerProtocol {
    var recipes = [Recipe]()
    
    var isPerformingRefresh: Bool = false
    
    var hasContent: Bool {
        return !recipes.isEmpty
    }
    
    private var changeClosure: ((IdeasChange) -> Void)?
    private let lock = NSLock()
    
    func loadList() {
        isPerformingRefresh = true
        fetchList()
    }
    
    private func fetchList() {
        lock.lock(); defer { lock.unlock() }
        changeClosure?(.startedLoading)
        
        ServiceLayer.request(router: Router.getLatestRecipes) { [weak self] (result: Result<[String: [Recipe]], Error>) in
            switch result {
            case let .success(res):
                let recipes = res["meals"] ?? []
                self?.recipes = recipes
                self?.changeClosure?(.finishedLoading(.success(recipes)))
            case let .failure(error):
                Logger.log(message: "Failed to fetch latest recipes", type: .error)
                self?.changeClosure?(.finishedLoading(.failure(error)))
            }
        }
    }
    
    func onChange(_ completion: ((IdeasChange) -> Void)?) {
        changeClosure = completion
    }
    
}
