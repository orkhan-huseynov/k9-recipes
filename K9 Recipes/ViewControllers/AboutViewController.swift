//
//  AboutViewController.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class AboutViewController: ASViewController<ASScrollNode> {
    
    private lazy var titleNode: TextNode = {
        let node = TextNode()
        node.font = .systemFont(ofSize: 25)
        node.color = .baseGray
        node.text = "K9 Recipes"
        node.alignment = .center
        return node
    }()
    
    private lazy var descriptionNode: TextNode = {
        let node = TextNode()
        node.font = .systemFont(ofSize: 17)
        node.color = .baseGray
        node.text = "Just came home after an exhausting work day, tired and hungry, can't think of an easy dinner idea? Or is it a weekend night and you don't want to waste your precious time for cooking for hours in kitchen? Or do you happen to have only a few ingredients in the fridge and you are not sure what to do with them?\n\nNo worries, K9 recipes app got you covered! Just pick ingredients you have and it will come up with carefully refined and creative dinner ideas. Select one you like most and have it on your table in no time thanks to detailed and intuitive instructions in the recipe!"
        return node
    }()
    
    private lazy var infoNode: TextNode = {
        let node = TextNode()
        node.font = .italicSystemFont(ofSize: 15)
        node.color = .baseGray
        node.text = "The name K9 was inspired from a fictional mechanical dog character appeared in Doctor Who sci-fi series. Our app is smart and helpful in the kitchen like original K9 was - intelligent, helpful and always loyal to Fourth Doctor"
        return node
    }()
    
    private lazy var versionNode: TextNode = {
        let version = Bundle.main.releaseVersion ?? "1.0"
        let build = Bundle.main.buildVersion ?? "1.0"
        
        let node = TextNode()
        node.font = .monospacedDigitSystemFont(ofSize: 14, weight: .regular)
        node.color = .baseGray
        node.alignment = .center
        node.text = "Version \(version)\nBuild \(build)"
        return node
    }()
    
    init() {
        super.init(node: ASScrollNode())
        
        node.backgroundColor = .white
        node.automaticallyManagesContentSize = true
        node.automaticallyManagesSubnodes = true
        
        node.layoutSpecBlock = { [weak self] _, constrainedSize in
            let stack: ASStackLayoutSpec = .vertical()
            guard let this = self else { return stack }
            
            stack.justifyContent = .start
            stack.spacing = 15.0
            stack.children = [
                this.titleNode,
                this.descriptionNode,
                this.infoNode,
                this.versionNode
            ]
            
            let insetsSpec = stack.insets(
                top: this.navigationBarHeight + this.statusBarHeight + 20.0,
                left: 15.0,
                bottom: this.tabBarHeight + 10.0,
                right: 15.0
            )
            
            return insetsSpec
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        (view as? UIScrollView)?.contentInsetAdjustmentBehavior = .never
        navigationItem.title = "About"
    }
    
}
