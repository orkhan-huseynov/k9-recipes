//
//  SearchResultsTableNodeItem.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

struct SearchResultsTableNodeItem {
    
    let title: String?
    let subtitle: String?
    let category: String?
    let area: String?
    let instructions: String?
    let image: String?
    var onSelect: (() -> Void)?
    
}
