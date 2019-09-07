//
//  SectionEmptyNode.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class SectionEmptyNode: ASScrollNode {
    
    var title: String?
    var image: UIImage?
    
    private lazy var imageNode: ASImageNode = {
        let node = ASImageNode()
        node.image = image ?? #imageLiteral(resourceName: "sad")
        node.contentMode = .center
        node.style.preferredSize = CGSize(width: 90.0, height: 90.0)
        return node
    }()
    
    private lazy var titleNode: TextNode = {
        let node = TextNode()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        node.attributedText = NSAttributedString(
            string: title ?? "",
            attributes: [
                .font: UIFont.systemFont(ofSize: 17.0),
                .foregroundColor: UIColor.baseBlack,
                .paragraphStyle: paragraphStyle
            ]
        )
        
        return node
    }()
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack: ASStackLayoutSpec = .vertical()
        
        stack.justifyContent = .spaceAround
        stack.alignItems = .center
        stack.children = [
            ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: 80.0, left: 0, bottom: 0, right: 0),
                child: imageNode
            ),
            titleNode
        ]
        stack.style.preferredSize = CGSize(
            width: constrainedSize.max.width,
            height: constrainedSize.max.height*0.4
        )
        
        return stack
    }
    
    override init() {
        super.init()
        
        automaticallyManagesContentSize = true
        automaticallyManagesSubnodes = true
        backgroundColor = .white
    }
}

