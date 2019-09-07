//
//  UIViewController+Helpers.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    public var navigationBarHeight: CGFloat {
        return navigationController?.navigationBar.frame.height ?? 0.0
    }
    
    public var tabBarHeight: CGFloat {
        return tabBarController?.tabBar.frame.size.height ?? 0.0
    }
    
}
