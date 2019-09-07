//
//  RecipesViewController.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class RecipesViewController: ASViewController<ASDisplayNode> {
    
    init() {
        super.init(node: ASDisplayNode())
        
        node.backgroundColor = .white
        node.automaticallyManagesSubnodes = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}
