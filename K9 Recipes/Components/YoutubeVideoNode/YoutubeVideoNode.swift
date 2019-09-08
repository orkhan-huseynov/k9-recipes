//
//  YoutubeVideoNode.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit
import YoutubePlayer_in_WKWebView

class YoutubeVideoNode: ASDisplayNode {
    
    var videoLink: String? {
        didSet {
            guard let link = videoLink else { return }
            if let id = URLComponents(string: link)?.queryItems?.first(where: { $0.name == "v" })?.value {
                videoView.load(withVideoId: id)
            }
        }
    }
    
    private lazy var videoView: WKYTPlayerView = {
        WKYTPlayerView()
    }()
    
    
    private lazy var videoNode: ASDisplayNode = {
        ASDisplayNode(viewBlock: { [weak self] in
            return self?.videoView ?? UIView()
        })
    }()
    
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        backgroundColor = .white
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        videoNode.style.preferredSize = constrainedSize.max
        return ASWrapperLayoutSpec(layoutElement: videoNode)
    }
}
