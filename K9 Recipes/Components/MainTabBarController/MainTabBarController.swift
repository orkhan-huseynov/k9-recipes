//
//  MainTabBarController.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private lazy var tabs: [UIViewController] = {
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(title: "Find recipe", image: #imageLiteral(resourceName: "search"), tag: 0)
        
        let ideasVC = IdeasViewController()
        ideasVC.tabBarItem = UITabBarItem(title: "Dinner ideas", image: #imageLiteral(resourceName: "bulb"), tag: 1)
        
        let recipesVC = RecipesViewController()
        recipesVC.tabBarItem = UITabBarItem(title: "By categories", image: #imageLiteral(resourceName: "book"), tag: 2)
        
        return [searchVC, ideasVC, recipesVC]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .baseGreen
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.baseGreen], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        
        viewControllers = tabs.map { UINavigationController(rootViewController: $0) }
    }
}
