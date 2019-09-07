//
//  Array+SafeSubscript.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

extension Array {
    subscript (safe index: Int) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
    }
}
