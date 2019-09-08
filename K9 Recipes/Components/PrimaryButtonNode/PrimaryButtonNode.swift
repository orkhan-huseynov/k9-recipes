//
//  PrimaryButtonNode.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class PrimaryButtonNode: ButtonNode {
    
    override var isEnabled: Bool {
        didSet {
            setTitle(title ?? "", with: .systemFont(ofSize: 17), with: color, for: .normal)
            backgroundColor = isEnabled ? enabledBgColor : disabledBgColor
        }
    }
    
    var enabledBgColor: UIColor = .baseGreen {
        didSet {
            setTitle(title ?? "", with: .systemFont(ofSize: 17), with: color, for: .normal)
        }
    }
    
    var disabledBgColor: UIColor = .baseGreen50 {
        didSet {
            setTitle(title ?? "", with: .systemFont(ofSize: 17), with: color, for: .normal)
        }
    }
    
    override init() {
        super.init()
        
        cornerRadius = .cornerRadius
        style.preferredSize.height = 55.0
        enabledColor = .white
        disabledColor = .baseWhite
    }
    
}
