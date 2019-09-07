//
//  Logger.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import Foundation
import os.log

class Logger {
    public static let shared = Logger()
    
    public static func log(message: String, type: OSLogType) {
        shared.log(message: message, type: type)
    }
    
    func log(message: String, type: OSLogType) {
        if #available(iOS 12.0, *) {
            os_log(.error, "%@", message)
        } else {
            os_log("%@", message)
        }
    }
}
