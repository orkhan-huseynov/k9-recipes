//
//  AlertController.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import UIKit

class AlertController {
    
    public static let shared = AlertController()
    private init() {}
    
    func message(title: String, message: String?, completion: (() -> Void)? = .none) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: .default,
                handler: { _ in
                    completion?()
            }
            )
        )
        
        if let presenter = UIApplication.shared.keyWindow?.rootViewController {
            presenter.present(alert, animated: true)
        } else {
            completion?()
        }
    }
}
