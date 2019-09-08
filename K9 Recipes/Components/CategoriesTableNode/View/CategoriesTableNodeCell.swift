//
//  CategoriesTableNodeCell.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class CategoriesTableNodeCell: ASCellNode {
    var item: CategoriesTableNodeItem?
    
    lazy var imageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.url = URL(string: item?.image ?? "")
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    lazy var gradientOverlayNode: ASDisplayNode = {
        ASDisplayNode(layerBlock: {
            let gradient = CAGradientLayer()
            gradient.colors = [UIColor.clear.cgColor, UIColor.baseGray.cgColor]
            gradient.locations = [0.0, 1.0]
            return gradient
        })
    }()
    
    private lazy var titleNode: TextNode = {
        let node = TextNode(text: item?.title)
        node.font = .boldSystemFont(ofSize: 25)
        node.color = .white
        return node
    }()
    
    init(item: CategoriesTableNodeItem) {
        self.item = item
        super.init()
        automaticallyManagesSubnodes = true
        selectionStyle = .none
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredSize = constrainedSize.max
        
        let overlayedImageSpec = ASOverlayLayoutSpec(child: imageNode, overlay: gradientOverlayNode)
        titleNode.style.layoutPosition = CGPoint(x: 15.0, y: constrainedSize.max.height - 50.0)
        
        return ASOverlayLayoutSpec(child: overlayedImageSpec, overlay: ASAbsoluteLayoutSpec(children: [titleNode]))
    }
}
