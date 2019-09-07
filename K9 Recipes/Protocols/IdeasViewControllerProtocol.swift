//
//  IdeasViewControllerProtocol.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

protocol IdeasViewControllerProtocol: class {
    // MARK: - Props
    var recipes: [Recipe] { get }
    var isPerformingRefresh: Bool { get }
    var hasContent: Bool { get }
    
    // MARK: - Requests
    func loadList()
    
    // MARK: - Observers
    func onChange(_ completion: ((IdeasChange) -> Void)?)
}

enum IdeasChange {
    case startedLoading
    case finishedLoading(Result<[Recipe], Error>)
}
