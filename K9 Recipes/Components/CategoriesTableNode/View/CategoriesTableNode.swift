//
//  CategoriesTableNode.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class CategoriesTableNode: TableNodeBase, ASTableDelegate, ASTableDataSource, UITableViewDelegate {
    
    var data: [CategoriesTableNodeItem]?
    var onTap: (() -> Void)?
    var swipeActions: ((IndexPath) -> [SwipeAction])?
    
    override init() {
        super.init()
        
        delegate = self
        dataSource = self
    }
    
    convenience init(with items: [CategoriesTableNodeItem]?) {
        self.init()
        self.data = items
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard data?.count ?? 0 > indexPath.row, let itemModel = data?[safe: indexPath.row] else {
            return { ASCellNode() }
        }
        
        return { CategoriesTableNodeCell(item: itemModel) }
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        if let onTap = onTap {
            onTap()
        } else {
            data?[safe: indexPath.row]?.onSelect?()
        }
        
        view.deselectRow(at: indexPath, animated: false)
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRange(min: CGSize(width: 0, height: 0), max: CGSize(width: 0, height: tableNode.style.preferredSize.width*0.7))
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let actions = swipeActions?(indexPath)
        return !(actions?.isEmpty ?? true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actions = swipeActions?(indexPath)
        return UISwipeActionsConfiguration(actions: actions?.map { action in
            let contextualAction = UIContextualAction(
                style: .normal,
                title: action.title,
                handler: { (_, _, success: (Bool) -> Void)  in
                    action.handler(indexPath)
                    success(true)
                }
            )
            
            contextualAction.image = action.image
            contextualAction.backgroundColor = action.backgroundColor
            
            return contextualAction
        } ?? [])
    }
}
