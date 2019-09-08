//
//  SearchResultsViewControllerProtocol.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

protocol SearchResultsViewControllerProtocol: class {
    // MARK: - Props
    var recipes: [Recipe] { get }
    var isPerformingRefresh: Bool { get }
    var hasContent: Bool { get }
    
    // MARK: - Requests
    func loadList(query: String?)
    
    // MARK: - Observers
    func onChange(_ completion: ((SearchResultsChange) -> Void)?)
}

enum SearchResultsChange {
    case startedLoading
    case finishedLoading(Result<[Recipe], Error>)
}
