//
//  SearchResultsTableNodeCell.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class SearchResultsTableNodeCell: ASCellNode {
    var item: SearchResultsTableNodeItem?
    
    lazy var imageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.url = URL(string: item?.image ?? "")
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    lazy var gradientOverlayNode: ASDisplayNode = {
        ASDisplayNode(layerBlock: {
            let gradient = CAGradientLayer()
            gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
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
    
    private lazy var subtitleNode: TextNode = {
        let node = TextNode(text: item?.subtitle)
        node.font = .boldSystemFont(ofSize: 14)
        node.color = .white
        node.maximumNumberOfLines = 1
        return node
    }()
    
    init(item: SearchResultsTableNodeItem) {
        self.item = item
        super.init()
        automaticallyManagesSubnodes = true
        selectionStyle = .none
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredSize = constrainedSize.max
        
        let overlayedImageSpec = ASOverlayLayoutSpec(child: imageNode, overlay: gradientOverlayNode)
        
        let bottomStack: ASStackLayoutSpec = .vertical()
        bottomStack.justifyContent = .end
        bottomStack.spacing = 10.0
        bottomStack.style.preferredSize = CGSize(
            width: constrainedSize.max.width,
            height: 90.0
        )
        bottomStack.children = [titleNode, subtitleNode]
        
        let insetSpec = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0.0, left: 15.0, bottom: 20.0, right: 0.0),
            child: bottomStack
        )
        
        return ASOverlayLayoutSpec(child: overlayedImageSpec, overlay: insetSpec)
    }
}
