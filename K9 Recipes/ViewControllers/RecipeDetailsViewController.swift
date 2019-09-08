//
//  RecipeDetailsViewController.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class RecipeDetailsViewController: ASViewController<ASScrollNode> {
    var recipe: Recipe?
    var viewModel: RecipeDetailsViewControllerProtocol = RecipeDetailsViewModel()
    
    var isEmpty: Bool = true {
        didSet(val) {
            node.setNeedsLayout()
        }
    }
    
    private lazy var loaderNode: ASDisplayNode = {
        let node = ASDisplayNode(viewBlock: {
            let view = UIActivityIndicatorView()
            view.color = .baseGreen
            view.startAnimating()
            return view
        })
        node.style.preferredSize.height = 50.0
        return node
    }()
    
    private lazy var segmentedNode: SegmentedControlNode = {
        let node = SegmentedControlNode()
        node.segments = ["Overview", "Ingredients", "Video"]
        node.onSelect = { [weak self] _ in
            self?.node.setNeedsLayout()
        }
        return node
    }()
    
    private lazy var imageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.url = URL(string: recipe?.image ?? "")
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    private lazy var titleNode: TextNode = {
        let node = TextNode(text: recipe?.title)
        node.font = .systemFont(ofSize: 20)
        node.color = .baseBlack
        node.style.preferredSize.height = 30.0
        return node
    }()
    
    private lazy var categoryNode: TextNode = {
        let node = TextNode(text: "Category: \(recipe?.category ?? "")")
        node.font = .systemFont(ofSize: 14)
        node.color = .baseBlack
        node.style.preferredSize.height = 20.0
        return node
    }()
    
    private lazy var areaNode: TextNode = {
        let node = TextNode(text: "Area: \(recipe?.area ?? "")")
        node.font = .systemFont(ofSize: 14)
        node.color = .baseBlack
        node.style.preferredSize.height = 20.0
        return node
    }()
    
    private lazy var instructionsTitleNode: TextNode = {
        let node = TextNode(text: "Instructions:")
        node.font = .systemFont(ofSize: 14)
        node.color = .baseBlack
        node.maximumNumberOfLines = 0
        node.style.preferredSize.height = 20.0
        return node
    }()
    
    private lazy var instructionsNode: TextNode = {
        let node = TextNode(text: recipe?.instructions)
        node.font = .systemFont(ofSize: 14)
        node.color = .baseBlack
        node.style.flexGrow = 1
        return node
    }()
    
    private lazy var youtubeVideoNode: YoutubeVideoNode = {
        let node = YoutubeVideoNode()
        node.videoLink = recipe?.youtubeLink
        return node
    }()
    
    private lazy var stepsNode: TextNode = {
        let node = TextNode()
        node.style.preferredSize.height = recipe?.steps.filter { !$0.measure.isEmpty }.reduce(0) { el, _ in el + 20 } ?? 0
        node.truncationAttributedText = NSAttributedString(string: "")
        
        let attributedString = NSMutableAttributedString()
        
        recipe?.steps.forEach { step in
            attributedString.append(
                NSAttributedString(
                    string: step.measure,
                    attributes: [
                        .foregroundColor: UIColor.baseGreen,
                        .font: UIFont.boldSystemFont(ofSize: 17),
                    ]
                )
            )
            attributedString.append(NSAttributedString(string: " "))
            attributedString.append(
                NSAttributedString(
                    string: step.ingredient.lowercased(),
                    attributes: [
                        .foregroundColor: UIColor.baseGray,
                        .font: UIFont.systemFont(ofSize: 17),
                    ]
                )
            )
            attributedString.append(NSAttributedString(string: "\n\n"))
        }
        
        node.attributedText = attributedString
        
        return node
    }()
    
    init(recipe: Recipe) {
        super.init(node: ASScrollNode())
        
        self.recipe = recipe
        
        node.backgroundColor = .white
        node.automaticallyManagesContentSize = true
        node.automaticallyManagesSubnodes = true
        
        node.layoutSpecBlock = { [weak self] _, constrainedSize in
            let stack: ASStackLayoutSpec = .vertical()
            guard let this = self else { return stack }
            
            this.imageNode.style.preferredSize = CGSize(
                width: constrainedSize.max.width,
                height: constrainedSize.max.width
            )
            
            stack.justifyContent = .start
            stack.children = [
                this.imageNode,
                this.titleNode.insets(top: 12.0, left: 15.0, bottom: 10.0, right: 15.0)
            ]
            
            if this.isEmpty {
                stack.children?.append(this.loaderNode)
            } else {
                stack.children?.append(this.segmentedNode.insets(top: 0.0, left: 15.0, bottom: 5.0, right: 15.0))
                
                switch this.segmentedNode.selectedIndex {
                case 1:
                    stack.children?.append(this.stepsNode.insets(top: 5.0, left: 15.0, bottom: 0.0, right: 15.0))
                case 2:
                    this.youtubeVideoNode.style.preferredSize = CGSize(
                        width: constrainedSize.max.width,
                        height: constrainedSize.max.width*0.7
                    )
                    stack.children?.append(this.youtubeVideoNode.insets(top: 5.0, left: 15.0, bottom: 10.0, right: 15.0))
                default:
                    stack.children?.append(this.categoryNode.insets(top: 5.0, left: 15.0, bottom: 0.0, right: 15.0))
                    stack.children?.append(this.areaNode.insets(top: 5.0, left: 15.0, bottom: 0.0, right: 15.0))
                    stack.children?.append(ASDisplayNode.separator())
                    stack.children?.append(this.instructionsTitleNode.insets(top: 5.0, left: 15.0, bottom: 0.0, right: 15.0))
                    stack.children?.append(this.instructionsNode.insets(top: 5.0, left: 15.0, bottom: 10.0, right: 15.0))
                }
                
                
            }
            
            stack.children?.forEach {
                $0.style.preferredSize.width = constrainedSize.max.width
            }
            
            return stack
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
        viewModel.getDetails(recipeId: recipe?.id)
        
        navigationItem.title = recipe?.title
        setBackTitle()
    }
    
    func prepare() {
        viewModel.onChange { [weak self] event in
            switch event {
            case .startedLoading:
                if !(self?.viewModel.hasContent ?? false) {
                    
                }
            case let .finishedLoading(result):
                switch result {
                case let .success(recipe):
                    self?.recipe = recipe
                    self?.isEmpty = recipe == nil
                    
                case .failure:
                    self?.isEmpty = true
                }
            }
        }
    }
    
}
