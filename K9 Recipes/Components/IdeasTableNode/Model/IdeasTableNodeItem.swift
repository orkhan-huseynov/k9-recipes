//
//  IdeasTableNodeItem.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

struct IdeasTableNodeItem {
    
    let title: String?
    let category: String?
    let area: String?
    let instructions: String?
    let image: String?
    var onSelect: (() -> Void)?
    
}
