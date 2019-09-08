//
//  Bundle+Versions.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import Foundation

extension Bundle {
    var releaseVersion: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildVersion: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
