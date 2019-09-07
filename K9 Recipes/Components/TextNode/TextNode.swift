//
//  TextNode.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class TextNode: ASTextNode {
    
    private var attributes = [
        NSAttributedString.Key.foregroundColor: UIColor.baseBlack,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)
    ] {
        didSet {
            setAttributes()
        }
    }
    
    var onTap: (() -> Void)? {
        willSet(val) {
            if val != nil {
                addTarget(self, action: #selector(tapHandler), forControlEvents: .touchUpInside)
            } else {
                removeTarget(self, action: #selector(tapHandler), forControlEvents: .touchUpInside)
            }
        }
    }
    
    var text: String? {
        get {
            return attributedText?.string
        }
        set(val) {
            attributedText = NSAttributedString(string: val ?? "", attributes: attributes)
        }
    }
    
    var font: UIFont? {
        get {
            return attributes[NSAttributedString.Key.font] as? UIFont
        }
        set(val) {
            attributes[NSAttributedString.Key.font] = val ?? .systemFont(ofSize: 14.0)
        }
    }
    
    var color: UIColor? {
        get {
            return attributes[NSAttributedString.Key.foregroundColor] as? UIColor
        }
        set(val) {
            attributes[NSAttributedString.Key.foregroundColor] = val ?? .baseBlack
        }
    }
    
    var alignment: NSTextAlignment {
        get {
            return (attributes[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle)?.alignment ?? .left
        }
        set(val) {
            let style = NSMutableParagraphStyle()
            style.alignment = val
            attributes[NSAttributedString.Key.paragraphStyle] = style
        }
    }
    
    init(text: String? = nil) {
        super.init()
        
        self.text = text
    }
    
    convenience init(text: String?, color: UIColor?) {
        self.init(text: text)
        
        defer {
            self.color = color
            self.font = font
        }
    }
    
    @objc private func tapHandler() { onTap?() }
    
    private func setAttributes() {
        attributedText = NSAttributedString(string: text ?? "", attributes: attributes)
    }
    
}

