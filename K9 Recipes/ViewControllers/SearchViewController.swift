//
//  SearchViewController.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class SearchViewController: ASViewController<ASScrollNode> {
    
    var viewModel: SearchViewControllerProtocol = SearchViewModel()
    
    var isEmpty: Bool = false {
        didSet(val) {
            node.setNeedsLayout()
        }
    }
    
    private lazy var emptyNode: SectionEmptyNode = {
        let node = SectionEmptyNode()
        node.title = "Sorry!\nFailed to load ingredients."
        return node
    }()
    
    private lazy var emptyNodeRefreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        return control
    }()
    
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
        node.isEnabled = true
        node.onTap = { [weak self] in
            guard let mainIngredient = self?.mainIngredient.value else {
                self?.mainIngredient.view.shake()
                return
            }
            
            var query = mainIngredient
            
            if let secondaryIngredient = self?.secondaryIngredient.value {
                query += ",\(secondaryIngredient)"
            }
            
            if let additionalIngredient = self?.additionalIngredient.value {
                query += ",\(additionalIngredient)"
            }
            
            self?.navigationController?.pushViewController(
                SearchResultsViewController(query: query),
                animated: true
            )
        }
        
        return node
    }()
    
    private lazy var resetButton: ButtonNode = {
        let node = ButtonNode()
        node.title = "reset"
        node.isEnabled = true
        node.onTap = { [weak self] in
            self?.mainIngredient.value = .none
            self?.secondaryIngredient.value = .none
            self?.additionalIngredient.value = .none
        }
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

            this.emptyNode.style.preferredSize.width = constrainedSize.max.width
            this.emptyNode.style.flexGrow = 1
            let emptyStack: ASStackLayoutSpec = .vertical()
            emptyStack.children = [this.emptyNode]
            emptyStack.style.flexGrow = 1
            
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
            
            let emptyStackInsets = emptyStack.insets(
                top: this.navigationBarHeight + this.statusBarHeight,
                left: 0.0,
                bottom: this.tabBarHeight,
                right: 0.0
            )
            
            return this.isEmpty ? emptyStackInsets : ASBackgroundLayoutSpec(child: insetsSpec, background: this.bgNode)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
        viewModel.loadIngredients()
        
        emptyNode.view.showsVerticalScrollIndicator = false
        emptyNode.view.alwaysBounceVertical = true
        emptyNode.view.refreshControl = emptyNodeRefreshControl
     
        navigationItem.title = "Find recipes"
        (view as? UIScrollView)?.contentInsetAdjustmentBehavior = .never
        
        setBackTitle()
    }
    
    func prepare() {
        viewModel.onChange { [weak self] event in
            switch event {
            case .startedLoadingIngredients:
                if !(self?.viewModel.hasContent ?? false) {
                    ActivityIndicatorController.shared.present()
                }
            case let .finishedLoadingIngredients(result):
                ActivityIndicatorController.shared.dismiss()
                self?.emptyNodeRefreshControl.endRefreshing()

                switch result {
                case let .success(ingredients):
                    self?.isEmpty = ingredients.isEmpty

                    let autocompleteArr = ingredients.compactMap { $0.name }
                    
                    self?.mainIngredient.autocompletionStrings = autocompleteArr
                    self?.secondaryIngredient.autocompletionStrings = autocompleteArr
                    self?.additionalIngredient.autocompletionStrings = autocompleteArr
                case .failure:
                    AlertController.shared.message(title: "Error", message: "Sorry! Could not load ingredients list")
                }
            }
        }
    }
    
    @objc private func refreshHandler() {
        viewModel.loadIngredients()
    }
    
}

