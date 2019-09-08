//
//  Layout+Insets.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

extension ASDisplayNode {
    func insets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> ASLayoutSpec {
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right),
            child: self
        )
    }
}

extension ASLayoutSpec {
    func insets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> ASLayoutSpec {
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right),
            child: self
        )
    }
}
