//
//  TextControlNode.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class TextControlNode: ASControlNode {
    
    var title: String? {
        get {
            return label.text
        }
        set(val) {
            label.text = val
        }
    }
    
    var placeholder: String? {
        get {
            return textControl.placeholder
        }
        set(val) {
            textControl.placeholder = val
        }
    }
    
    var value: String? {
        get {
            return textControl.text
        }
        set(val) {
            textControl.text = val
        }
    }
    
    var onChange: ((String?) -> Void)? {
        get {
            return textControl.onChange
        }
        set(val) {
            textControl.onChange = val
        }
    }
    
    var autocompletionStrings: [String] {
        get {
            return textControl.autocompletionStrings
        }
        set(val) {
            textControl.autocompletionStrings = val
        }
    }
    
    private lazy var label: TextNode = {
        let node = TextNode()
        node.color = .baseBlack
        node.font = .systemFont(ofSize: 16)
        return node
    }()
    
    private lazy var textControl: EditableTextNode = {
        let node = EditableTextNode()
        node.placeholder = ""
        node.isEnabled = true
        return node
    }()
    
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        label.style.preferredSize.height = 26.0
        style.preferredSize.height = .editableTextNodeHeight + 30.0
        isUserInteractionEnabled = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack: ASStackLayoutSpec = .vertical()
        stack.spacing = 4.0
        
        stack.children = [label, textControl]
        
        return stack
    }
    
}
