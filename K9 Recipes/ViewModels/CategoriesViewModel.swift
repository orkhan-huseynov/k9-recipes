//
//  CategoriesViewModel.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import Foundation

class CategoriesViewModel: CategoriesViewControllerProtocol {
    var categories = [Category]()
    
    var isPerformingRefresh: Bool = false
    
    var hasContent: Bool {
        return !categories.isEmpty
    }
    
    private var changeClosure: ((CategoriesChange) -> Void)?
    private let lock = NSLock()
    
    func loadList() {
        isPerformingRefresh = true
        fetchList()
    }
    
    private func fetchList() {
        lock.lock(); defer { lock.unlock() }
        changeClosure?(.startedLoading)
        
        ServiceLayer.request(router: .getCategories) { [weak self] (result: Result<[String: [Category]], Error>) in
            switch result {
            case let .success(res):
                let categories = res["categories"] ?? []
                self?.categories = categories
                self?.changeClosure?(.finishedLoading(.success(categories)))
            case let .failure(error):
                Logger.log(message: "Failed to fetch categories", type: .error)
                self?.changeClosure?(.finishedLoading(.failure(error)))
            }
        }
    }
    
    func onChange(_ completion: ((CategoriesChange) -> Void)?) {
        changeClosure = completion
    }
    
}
