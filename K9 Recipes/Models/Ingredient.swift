//
//  Ingredient.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

struct Ingredient: Codable {
    let id: String?
    let name: String?
    let description: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idIngredient"
        case name = "strIngredient"
        case description = "strDescription"
        case type = "strType"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        type = try container.decodeIfPresent(String.self, forKey: .type)
    }
}
