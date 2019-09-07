//
//  TableNodeBase.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class TableNodeBase: ASTableNode {
    
    init() {
        super.init(style: .plain)
    }
    
    override func didLoad() {
        super.didLoad()
        
        view.tableFooterView = UIView(frame: .zero)
        view.tableHeaderView = UIView(frame: .zero)
        view.separatorStyle = .singleLine
        view.separatorInset = UIEdgeInsets.zero
        view.showsVerticalScrollIndicator = false
        view.separatorInsetReference = .fromCellEdges
    }
}

struct SwipeAction {
    let title: String
    let accessibilityIdentifier: String
    let image: UIImage
    let backgroundColor: UIColor
    let handler: ((IndexPath) -> Void)
}
