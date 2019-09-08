//
//  SeachViewControllerProtocol.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

protocol SearchViewControllerProtocol: class {
    // MARK: - Props
    var ingredients: [Ingredient] { get }
    var isPerformingRefresh: Bool { get }
    var hasContent: Bool { get }
    
    // MARK: - Requests
    func loadIngredients()
    
    // MARK: - Observers
    func onChange(_ completion: ((SearchChange) -> Void)?)
}

enum SearchChange {
    case startedLoadingIngredients
    case finishedLoadingIngredients(Result<[Ingredient], Error>)
}
