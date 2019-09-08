//
//  SearchResultsViewController.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class SearchResultsViewController: ASViewController<ASDisplayNode> {
    
    var viewModel: SearchResultsViewControllerProtocol = SearchResultsViewModel()
    var query: String?
    
    var isEmpty: Bool = false {
        didSet(val) {
            if isEmpty != val {
                node.setNeedsLayout()
            }
        }
    }
    
    private lazy var emptyNode: SectionEmptyNode = {
        let node = SectionEmptyNode()
        node.title = "Sorry!\nNothing found for your request.\nMaybe try to search by less ingredients?"
        return node
    }()
    
    private lazy var tableNode: SearchResultsTableNode = {
        let tableNode = SearchResultsTableNode()
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
    
    init(query: String) {
        super.init(node: ASDisplayNode())
        
        self.query = query
        
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
        viewModel.loadList(query: query)
        
        tableNode.view.refreshControl = tableRefreshControl
        
        emptyNode.view.showsVerticalScrollIndicator = false
        emptyNode.view.alwaysBounceVertical = true
        emptyNode.view.refreshControl = emptyNodeRefreshControl
        
        navigationItem.title = "Search Results"
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
                case let .success(recipes):
                    self?.isEmpty = recipes.isEmpty
                    self?.initRows(rows: recipes)
                case .failure:
                    self?.isEmpty = true
                }
            }
        }
    }
    
    func initRows(rows: [Recipe]) {
        tableNode.data = rows.map { row in
            SearchResultsTableNodeItem(
                title: row.title,
                subtitle: String(row.ingredients.prefix(3).reduce("") { "\($0), \($1)" }.dropFirst(2)),
                category: row.category,
                area: row.area,
                instructions: row.instructions,
                image: row.image,
                onSelect: { [weak self] in
                    let vc = RecipeDetailsViewController(recipe: row)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            )
        }
        tableNode.reloadData()
    }
    
    @objc private func refreshHandler() {
        viewModel.loadList(query: query)
    }
    
}
