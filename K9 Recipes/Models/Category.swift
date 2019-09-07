//
//  Category.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

struct Category: Codable {
    let id: String?
    let name: String?
    let image: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case image = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        description = try container.decodeIfPresent(String.self, forKey: .description)
    }
}
