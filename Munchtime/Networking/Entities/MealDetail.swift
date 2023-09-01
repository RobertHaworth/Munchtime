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
    let ingredients: [String] // strIngredient1-20
    let measurements: [String] // strMeasure1-20
    let source: String?
    let imageSource: String?
    let creativeCommonsConfirmed: String?
    let dateModified: String?

    static var previewData: MealDetail {
        return MealDetail(mealId: "0000",
                          mealName: "Teriyaki Chicken Casserole",
                          mealImage: URL(string: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg")!,
                          drinkAlternate: nil,
                          category: "Chicken",
                          locale: "Japanese",
                          instructions: "Preheat oven to 350\u{00b0} F. Spray a 9x13-inch baking pan with non-stick spray.\r\nCombine soy sauce, \u{00bd} cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.\r\nMeanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat.\r\nPlace the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks.\r\n*Meanwhile, steam or cook the vegetables according to package directions.\r\nAdd the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!",
                          tags: ["Meat", "Casserole"],
                          instructionVideo: "https://www.youtube.com/watch?v=4aZr5hZXP_s",
                          ingredients: ["soy sauce",
                                       "water",
                                       "brown sugar",
                                       "ground ginger",
                                       "minced garlic",
                                       "cornstarch",
                                       "chicken breasts",
                                       "stir-fry vegetables",
                                       "brown rice"],
                          measurements: ["3/4 cup",
                                        "1/2 cup",
                                        "1/4 cup",
                                        "1/2 teaspoon",
                                        "1/2 teaspoon",
                                        "4 Tablespoons",
                                        "2",
                                        "1 (12 oz.)",
                                        "3 cups"],
                          source: nil,
                          imageSource: nil,
                          creativeCommonsConfirmed: nil,
                          dateModified: nil)
    }
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
                           strIngredient20].compactMap({ $0 }).filter({ $0.isEmpty })

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
                            strMeasure20].compactMap({ $0 }).filter({ $0.isEmpty })
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
                          ingredients: ingredients,
                          measurements: measurements,
                          source: strSource,
                          imageSource: strImageSource,
                          creativeCommonsConfirmed: strCreativeCommonsConfirmed,
                          dateModified: dateModified)
    }
}
