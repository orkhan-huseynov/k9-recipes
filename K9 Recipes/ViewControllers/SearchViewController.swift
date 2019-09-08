//
//  SearchViewController.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class SearchViewController: ASViewController<ASScrollNode> {
    
    private lazy var bgNode: ASImageNode = {
        let node = ASImageNode()
        node.image = #imageLiteral(resourceName: "main-bg-blurred")
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    private lazy var titleNode: TextNode = {
        let node = TextNode()
        node.text = "What to cook tonight?"
        node.color = .baseGreen
        node.alignment = .center
        node.style.preferredSize.height = 40.0
        return node
    }()
    
    private lazy var mainIngredient: TextControlNode = {
        let node = TextControlNode()
        
        node.title = "Main ingredient"
        node.placeholder = "eg: Chicken"
        node.onChange = { [weak self] _ in
            self?.validateFields()
        }
        
        return node
    }()
    
    private lazy var secondaryIngredient: TextControlNode = {
        let node = TextControlNode()
        
        node.title = "Secondary ingredient"
        node.placeholder = "eg: Mushrooms"
        
        return node
    }()
    
    private lazy var additionalIngredient: TextControlNode = {
        let node = TextControlNode()
        
        node.title = "Additional ingredient"
        node.placeholder = "eg: Potatoes"
        
        return node
    }()
    
    private lazy var submitButton: PrimaryButtonNode = {
        let node = PrimaryButtonNode()
        
        node.title = "Find recipes!"
        node.isEnabled = false
        
        return node
    }()
    
    private lazy var resetButton: ButtonNode = {
        let node = ButtonNode()
        node.title = "reset"
        node.isEnabled = true
        return node
    }()

    init() {
        super.init(node: ASScrollNode())
        
        node.backgroundColor = .white
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        
        node.layoutSpecBlock = { [weak self] _, constrainedSize in
            let stack: ASStackLayoutSpec = .vertical()
            guard let this = self else { return stack }
            
            this.titleNode.font = .systemFont(ofSize: constrainedSize.max.width*0.08)
            
            let inputsStack: ASStackLayoutSpec = .vertical()
            inputsStack.spacing = 14.0
            inputsStack.style.preferredSize.height = 260
            inputsStack.children = [
                this.mainIngredient,
                this.secondaryIngredient,
                this.additionalIngredient
            ]
            
            let buttonsStack: ASStackLayoutSpec = .vertical()
            buttonsStack.spacing = 10.0
            buttonsStack.children = [this.submitButton, this.resetButton]
            buttonsStack.style.preferredSize.height = 80
            
            stack.justifyContent = .spaceAround
            stack.alignItems = .center
            stack.children = [this.titleNode, inputsStack, buttonsStack]
            stack.children?.forEach {
                $0.style.preferredSize.width = constrainedSize.max.width*0.75
            }
            
            let insetsSpec = stack.insets(
                top: this.navigationBarHeight + this.statusBarHeight,
                left: 0.0,
                bottom: this.tabBarHeight,
                right: 0.0
            )
            
            return ASBackgroundLayoutSpec(child: insetsSpec, background: this.bgNode)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        navigationItem.title = "Find recipes"
        (view as? UIScrollView)?.contentInsetAdjustmentBehavior = .never
    }

    private func validateFields() {
        submitButton.isEnabled = mainIngredient.value != nil
    }
    
}

