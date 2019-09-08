//
//  RecipesViewControllerProtocol.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

protocol RecipesViewControllerProtocol: class {
    // MARK: - Props
    var recipes: [Recipe] { get }
    var isPerformingRefresh: Bool { get }
    var hasContent: Bool { get }
    
    // MARK: - Requests
    func loadList(category: Category?)
    
    // MARK: - Observers
    func onChange(_ completion: ((RecipesChange) -> Void)?)
}

enum RecipesChange {
    case startedLoading
    case finishedLoading(Result<[Recipe], Error>)
}
