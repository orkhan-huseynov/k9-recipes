//
//  ASNavigationController+BackButton.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

extension ASNavigationController {
    func setBackButton() {
        navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back")
        navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "back")
    }
}

extension UIViewController {
    func setBackTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
