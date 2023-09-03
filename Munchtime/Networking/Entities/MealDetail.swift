//
//  MealDetail.swift
//  Munchtime
//
//  Created by Robert Haworth on 8/31/23.
//

import Foundation

struct MealDetail: Codable {
    let mealId: String
    let mealName: String
    let mealImage: URL
    let drinkAlternate: String? // strDrinkAlternate
    let category: String // strCategory
    let locale: String //strArea
    let instructions: String // strInstructions
    let tags: [String] // strTags
    let instructionVideo: String // strYoutube
    let ingredients: [Ingredient]
    let source: String?
    let imageSource: String?
    let creativeCommonsConfirmed: String?
    let dateModified: String?
}

struct Ingredient: Codable, Identifiable {
    let ingredientDescription: String
    let measurement: String

    var id: UUID { return UUID() }
}

struct MealDetailResponse: Codable {
    let meals: [MealDetailAPI]
}

struct MealDetailAPI: Codable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String? // strDrinkAlternate
    let strCategory: String? // strCategory
    let strArea: String? //strArea
    let strInstructions: String? // strInstructions
    let strMealThumb: URL
    let strTags: String? // strTags
    let strYoutube: String? // strYoutube

    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?

    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?

    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?

    func convert() -> MealDetail {
        let ingredients = [strIngredient1,
                           strIngredient2,
                           strIngredient3,
                           strIngredient4,
                           strIngredient5,
                           strIngredient6,
                           strIngredient7,
                           strIngredient8,
                           strIngredient9,
                           strIngredient10,
                           strIngredient11,
                           strIngredient12,
                           strIngredient13,
                           strIngredient14,
                           strIngredient15,
                           strIngredient16,
                           strIngredient17,
                           strIngredient18,
                           strIngredient19,
                           strIngredient20].compactMap({ $0 }).filter({ !$0.isEmpty })

        let measurements = [strMeasure1,
                            strMeasure2,
                            strMeasure3,
                            strMeasure4,
                            strMeasure5,
                            strMeasure6,
                            strMeasure7,
                            strMeasure8,
                            strMeasure9,
                            strMeasure10,
                            strMeasure11,
                            strMeasure12,
                            strMeasure13,
                            strMeasure14,
                            strMeasure15,
                            strMeasure16,
                            strMeasure17,
                            strMeasure18,
                            strMeasure19,
                            strMeasure20].compactMap({ $0 }).filter({ !$0.isEmpty })


        let mergedIngredients = zip(ingredients, measurements).map({ Ingredient(ingredientDescription: $0, measurement: $1) })

        let tags: [String] = (strTags ?? "").split(separator: ",", omittingEmptySubsequences: true).map({ String($0) })



        return MealDetail(mealId: idMeal,
                          mealName: strMeal,
                          mealImage: strMealThumb,
                          drinkAlternate: strDrinkAlternate,
                          category: strCategory ?? "Unknown Category",
                          locale: strArea ?? "Unknown Locale",
                          instructions: strInstructions ?? "Missing Instructions",
                          tags: tags,
                          instructionVideo: strYoutube ?? "Missing Video",
                          ingredients: mergedIngredients,
                          source: strSource,
                          imageSource: strImageSource,
                          creativeCommonsConfirmed: strCreativeCommonsConfirmed,
                          dateModified: dateModified)
    }
}
