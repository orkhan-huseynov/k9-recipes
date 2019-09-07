//
//  ServiceLayer.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import Foundation
import os.log

class ServiceLayer {
    class func request<T: Codable>(router: Router, completion: @escaping (Result<[String: [T]], Error>) -> ()) {
        var components = URLComponents()
        components.scheme = Constants.apiScheme
        components.host = Constants.apiHost
        components.path = router.path
        components.queryItems = router.parameters
        
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                Logger.log(message: error.localizedDescription, type: .error)
                return
            }
            
            guard response != nil else {
                Logger.log(message: "Could not get any response", type: .error)
                return
            }
            
            guard let data = data else {
                Logger.log(message: "Could not get response data", type: .error)
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode([String: [T]].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(responseObject))
                }
            } catch {
                Logger.log(message: "Could not decode response data", type: .error)
            }
        }
        dataTask.resume()
    }
}
