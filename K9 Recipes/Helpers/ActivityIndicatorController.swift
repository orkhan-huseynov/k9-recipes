//
//  ActivityIndicatorController.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import UIKit

class ActivityIndicatorController {
    static var shared = ActivityIndicatorController()
    
    var isActive: Bool {
        return activityIndicator.isAnimating
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .white)
        
        view.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        view.isUserInteractionEnabled = false
        view.color = .baseGreen
        
        DispatchQueue.main.async {
            if let window = UIApplication.shared.keyWindow {
                view.center = window.center
                window.addSubview(view)
            }
        }
        
        return view
    }()
    
    func present() {
        DispatchQueue.main.async { [unowned self] in
            if !self.isActive {
                self.activityIndicator.startAnimating()
            }
        }
    }
    
    func dismiss() {
        DispatchQueue.main.async { [unowned self] in
            if self.isActive {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
}
