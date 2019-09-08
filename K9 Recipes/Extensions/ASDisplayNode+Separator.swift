//
//  ASDisplayNode+Spacer.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

extension ASDisplayNode {
    static func separator() -> ASDisplayNode {
        let node = ASDisplayNode()
        node.style.preferredSize.height = 1.0
        node.backgroundColor = .basePaleGray
        return node
    }
}
