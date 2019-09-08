//
//  CategoriesViewController.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class CategoriesViewController: ASViewController<ASDisplayNode> {
    
    var viewModel: CategoriesViewControllerProtocol = CategoriesViewModel()
    
    var isEmpty: Bool = false {
        didSet(val) {
            if isEmpty != val {
                node.setNeedsLayout()
                emptyNode.view.setContentOffset(.zero, animated: true)
            }
        }
    }
    
    private lazy var emptyNode: SectionEmptyNode = {
        let node = SectionEmptyNode()
        node.title = "Sorry!\nNothing found for your request."
        return node
    }()
    
    private lazy var tableNode: CategoriesTableNode = {
        let tableNode = CategoriesTableNode()
        
        tableNode.style.flexGrow = 1
        tableNode.backgroundColor = .white
        
        return tableNode
    }()
    
    private lazy var tableRefreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        return control
    }()
    
    private lazy var emptyNodeRefreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        return control
    }()
    
    init() {
        super.init(node: ASDisplayNode())
        
        node.backgroundColor = .white
        node.automaticallyManagesSubnodes = true
        
        node.layoutSpecBlock = { [weak self] node, constrainedSize in
            guard let this = self else { return ASStackLayoutSpec() }
            
            this.tableNode.style.preferredSize = constrainedSize.max
            
            this.emptyNode.style.preferredSize = CGSize(
                width: constrainedSize.max.width,
                height: constrainedSize.max.height - this.tabBarHeight - this.navigationBarHeight - this.statusBarHeight
            )
            
            let emptyStack: ASStackLayoutSpec = .vertical()
            emptyStack.children = [this.emptyNode]
            emptyStack.style.preferredSize = constrainedSize.max
            
            return this.isEmpty ? emptyStack : ASWrapperLayoutSpec(layoutElement: this.tableNode)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
        viewModel.loadList()
        
        tableNode.view.refreshControl = tableRefreshControl
        
        emptyNode.view.showsVerticalScrollIndicator = false
        emptyNode.view.alwaysBounceVertical = true
        emptyNode.view.refreshControl = emptyNodeRefreshControl
        
        setBackTitle()
        
        navigationItem.title = "Meal Categories"
    }
    
    func prepare() {
        viewModel.onChange { [weak self] event in
            switch event {
            case .startedLoading:
                if !(self?.viewModel.hasContent ?? false) {
                    ActivityIndicatorController.shared.present()
                }
            case let .finishedLoading(result):
                ActivityIndicatorController.shared.dismiss()
                DispatchQueue.main.async {
                    self?.tableRefreshControl.endRefreshing()
                    self?.emptyNodeRefreshControl.endRefreshing()
                }
                
                switch result {
                case let .success(categories):
                    self?.isEmpty = categories.isEmpty
                    self?.initRows(rows: categories)
                case .failure:
                    AlertController.shared.message(title: "Error", message: "Sorry! Could not load the list")
                }
            }
        }
    }
    
    func initRows(rows: [Category]) {
        tableNode.data = rows.map { row in
            CategoriesTableNodeItem(
                title: row.name,
                image: row.image,
                onSelect: { [weak self] in
                    let vc = IdeasViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            )
        }
        tableNode.reloadData()
    }
    
    @objc private func refreshHandler() {
        viewModel.loadList()
    }
}

