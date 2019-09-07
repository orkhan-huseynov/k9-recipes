//
//  Recipe.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/7/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

struct Recipe: Codable {
    let id: String?
    let title: String?
    let drinkAlternate: String?
    let category: String?
    let area: String?
    let instructions: String?
    let image: String?
    let tags: String?
    let youtubeLink: String?
    let source: String?
    
    let ingredients: [String]
    let ingredient1: String?
    let ingredient2: String?
    let ingredient3: String?
    let ingredient4: String?
    let ingredient5: String?
    let ingredient6: String?
    let ingredient7: String?
    let ingredient8: String?
    let ingredient9: String?
    let ingredient10: String?
    let ingredient11: String?
    let ingredient12: String?
    let ingredient13: String?
    let ingredient14: String?
    let ingredient15: String?
    let ingredient16: String?
    let ingredient17: String?
    let ingredient18: String?
    let ingredient19: String?
    let ingredient20: String?
    
    let measures: [String]
    let measure1: String?
    let measure2: String?
    let measure3: String?
    let measure4: String?
    let measure5: String?
    let measure6: String?
    let measure7: String?
    let measure8: String?
    let measure9: String?
    let measure10: String?
    let measure11: String?
    let measure12: String?
    let measure13: String?
    let measure14: String?
    let measure15: String?
    let measure16: String?
    let measure17: String?
    let measure18: String?
    let measure19: String?
    let measure20: String?
    
    var steps: [RecipeStep] {
        return ingredients.enumerated().map { RecipeStep(ingredient: $0.element, measure: measures[$0.offset]) }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case title = "strMeal"
        case drinkAlternate = "strDrinkAlternate"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case image = "strMealThumb"
        case tags = "strTags"
        case youtubeLink = "strYoutube"
        case source = "strSource"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
        case measure16 = "strMeasure16"
        case measure17 = "strMeasure17"
        case measure18 = "strMeasure18"
        case measure19 = "strMeasure19"
        case measure20 = "strMeasure20"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        drinkAlternate = try container.decodeIfPresent(String.self, forKey: .drinkAlternate)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        area = try container.decodeIfPresent(String.self, forKey: .area)
        instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        tags = try container.decodeIfPresent(String.self, forKey: .tags)
        youtubeLink = try container.decodeIfPresent(String.self, forKey: .youtubeLink)
        source = try container.decodeIfPresent(String.self, forKey: .source)
        
        ingredient1 = try container.decodeIfPresent(String.self, forKey: .ingredient1)
        ingredient2 = try container.decodeIfPresent(String.self, forKey: .ingredient2)
        ingredient3 = try container.decodeIfPresent(String.self, forKey: .ingredient3)
        ingredient4 = try container.decodeIfPresent(String.self, forKey: .ingredient4)
        ingredient5 = try container.decodeIfPresent(String.self, forKey: .ingredient5)
        ingredient6 = try container.decodeIfPresent(String.self, forKey: .ingredient6)
        ingredient7 = try container.decodeIfPresent(String.self, forKey: .ingredient7)
        ingredient8 = try container.decodeIfPresent(String.self, forKey: .ingredient8)
        ingredient9 = try container.decodeIfPresent(String.self, forKey: .ingredient9)
        ingredient10 = try container.decodeIfPresent(String.self, forKey: .ingredient10)
        ingredient11 = try container.decodeIfPresent(String.self, forKey: .ingredient11)
        ingredient12 = try container.decodeIfPresent(String.self, forKey: .ingredient12)
        ingredient13 = try container.decodeIfPresent(String.self, forKey: .ingredient13)
        ingredient14 = try container.decodeIfPresent(String.self, forKey: .ingredient14)
        ingredient15 = try container.decodeIfPresent(String.self, forKey: .ingredient15)
        ingredient16 = try container.decodeIfPresent(String.self, forKey: .ingredient16)
        ingredient17 = try container.decodeIfPresent(String.self, forKey: .ingredient17)
        ingredient18 = try container.decodeIfPresent(String.self, forKey: .ingredient18)
        ingredient19 = try container.decodeIfPresent(String.self, forKey: .ingredient19)
        ingredient20 = try container.decodeIfPresent(String.self, forKey: .ingredient20)
        
        measure1 = try container.decodeIfPresent(String.self, forKey: .measure1)
        measure2 = try container.decodeIfPresent(String.self, forKey: .measure2)
        measure3 = try container.decodeIfPresent(String.self, forKey: .measure3)
        measure4 = try container.decodeIfPresent(String.self, forKey: .measure4)
        measure5 = try container.decodeIfPresent(String.self, forKey: .measure5)
        measure6 = try container.decodeIfPresent(String.self, forKey: .measure6)
        measure7 = try container.decodeIfPresent(String.self, forKey: .measure7)
        measure8 = try container.decodeIfPresent(String.self, forKey: .measure8)
        measure9 = try container.decodeIfPresent(String.self, forKey: .measure9)
        measure10 = try container.decodeIfPresent(String.self, forKey: .measure10)
        measure11 = try container.decodeIfPresent(String.self, forKey: .measure11)
        measure12 = try container.decodeIfPresent(String.self, forKey: .measure12)
        measure13 = try container.decodeIfPresent(String.self, forKey: .measure13)
        measure14 = try container.decodeIfPresent(String.self, forKey: .measure14)
        measure15 = try container.decodeIfPresent(String.self, forKey: .measure15)
        measure16 = try container.decodeIfPresent(String.self, forKey: .measure16)
        measure17 = try container.decodeIfPresent(String.self, forKey: .measure17)
        measure18 = try container.decodeIfPresent(String.self, forKey: .measure18)
        measure19 = try container.decodeIfPresent(String.self, forKey: .measure19)
        measure20 = try container.decodeIfPresent(String.self, forKey: .measure20)
        
        //these loops are bad but its due to API is not perfect
        var ingredientsArr = [String]()
        for i in 1...20 {
            guard let key = CodingKeys(rawValue: "strIngredient\(i)") else { continue }
            guard let ingredient = try container.decodeIfPresent(String.self, forKey: key) else { continue }
            
            ingredientsArr.append(ingredient)
        }
        ingredients = ingredientsArr
        
        var measuressArr = [String]()
        for i in 1...20 {
            guard let key = CodingKeys(rawValue: "strMeasure\(i)") else { continue }
            guard let measure = try container.decodeIfPresent(String.self, forKey: key) else { continue }
            
            measuressArr.append(measure)
        }
        measures = measuressArr
    }
}
