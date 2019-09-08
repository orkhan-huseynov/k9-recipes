//
//  CategoriesViewControllerProtocol.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

protocol CategoriesViewControllerProtocol: class {
    // MARK: - Props
    var categories: [Category] { get }
    var isPerformingRefresh: Bool { get }
    var hasContent: Bool { get }
    
    // MARK: - Requests
    func loadList()
    
    // MARK: - Observers
    func onChange(_ completion: ((CategoriesChange) -> Void)?)
}

enum CategoriesChange {
    case startedLoading
    case finishedLoading(Result<[Category], Error>)
}
