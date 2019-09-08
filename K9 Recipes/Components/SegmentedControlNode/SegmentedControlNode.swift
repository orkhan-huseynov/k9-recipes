//
//  SegmentedControlNode.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

class SegmentedControlNode: ASControlNode {
    
    var segments: [String] = [] {
        didSet {
            segmentedControl.removeAllSegments()
            
            segments.enumerated().forEach { index, segment in
                segmentedControl.insertSegment(withTitle: segment, at: index, animated: false)
            }
            
            segmentedControl.selectedSegmentIndex = 0
            setNeedsLayout()
        }
    }
    var onSelect: ((Int) -> Void)?
    
    var selectedIndex: Int {
        get {
            return segmentedControl.selectedSegmentIndex
        }
        set(val) {
            segmentedControl.selectedSegmentIndex = val
        }
    }
    
    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.tintColor = .baseGreen
        control.addTarget(self, action: #selector(handleSelection), for: .valueChanged)
        return control
    }()
    
    private lazy var segmentedControlNode: ASDisplayNode = {
        let node = ASDisplayNode(viewBlock: { [weak self] in
            return self?.segmentedControl ?? UIView()
        })
        node.style.preferredSize.height = 40.0
        return node
    }()
    
    override init() {
        super.init()
        
        style.preferredSize.height = 40.0
        automaticallyManagesSubnodes = true
        isUserInteractionEnabled = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: segmentedControlNode)
    }
    
    @objc private func handleSelection() {
        onSelect?(segmentedControl.selectedSegmentIndex)
    }
}
