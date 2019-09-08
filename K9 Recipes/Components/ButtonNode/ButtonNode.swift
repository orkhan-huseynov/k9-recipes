//
//  ButtonNode.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class ButtonNode: ASButtonNode {
    
    var onTap: (() -> Void)?
    
    override var isEnabled: Bool {
        didSet {
            setTitle(title ?? "", with: .systemFont(ofSize: 17), with: color, for: .normal)
        }
    }
    
    var enabledColor: UIColor = .baseGreen {
        didSet {
            setTitle(title ?? "", with: .systemFont(ofSize: 17), with: color, for: .normal)
        }
    }
    
    var disabledColor: UIColor = .baseGray {
        didSet {
            setTitle(title ?? "", with: .systemFont(ofSize: 17), with: color, for: .normal)
        }
    }
    
    var color: UIColor? {
        return isEnabled ? enabledColor : disabledColor
    }
    
    var title: String? {
        get {
            return attributedTitle(for: .normal)?.string
        }
        set(val) {
            setTitle(val ?? "", with: .systemFont(ofSize: 14), with: color, for: .normal)
        }
    }
    
    var icon: UIImage? {
        get {
            return image(for: .normal)
        }
        set(val) {
            setImage(val, for: .normal)
        }
    }
    
    @objc private func tapHandler() {
        onTap?()
    }
    
    override init() {
        super.init()
        
        style.preferredSize.height = 25.0
    }
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func didLoad() {
        super.didLoad()
        addTarget(self, action: #selector(tapHandler), forControlEvents: .touchUpInside)
    }
    
}
