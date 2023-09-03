//
//  PreviewExtensions.swift
//  Munchtime
//
//  Created by Robert Haworth on 9/3/23.
//

import Foundation


extension Meal {
    static var previewItem: Meal {
        return Meal(mealName: "Krispy Kreme Donut",
                    mealImage: URL(string: "https://www.themealdb.com/images/media/meals/4i5cnx1587672171.jpg")!,
                    mealId: "53015")
    }
}

/// Mirroring the data found within the mealdb datastructures. Looking deeper into the ingredients and measurements, these measurements seem to not line up correctly with ingredients but this correctly matches the data being returned from the server.
extension MealDetail {
    static var previewItem: MealDetail {
        return MealDetail(mealId: "53015",
                          mealName: "Krispy Kreme Donut",
                          mealImage: URL(string: "https://www.themealdb.com/images/media/meals/4i5cnx1587672171.jpg")!,
                          drinkAlternate: nil,
                          category: "Dessert",
                          locale: "American",
                          instructions: "Dissolve yeast in warm water in 2 1/2-quart bowl. Add milk, sugar, salt, eggs, shortening and 2 cups flour. Beat on low for 30 seconds, scraping bowl constantly. Beat on medium speed for 2 minutes, scraping bowl occasionally. Stir in remaining flour until smooth. Cover and let rise until double, 50-60 minutes. (Dough is ready when indentation remains when touched.) Turn dough onto floured surface; roll around lightly to coat with flour. Gently roll dough 1/2-inch thick with floured rolling pin. Cut with floured doughnut cutter. Cover and let rise until double, 30-40 minutes.\r\nHeat vegetable oil in deep fryer to 350\u{00b0}. Slide doughnuts into hot oil with wide spatula. Turn doughnuts as they rise to the surface. Fry until golden brown, about 1 minute on each side. Remove carefully from oil (do not prick surface); drain. Dip the doughnuts into creamy glaze set on rack.\r\n\r\n\r\nGlaze: \r\nHeat butter until melted. Remove from heat. Stir in powdered sugar and vanilla until smooth. Stir in water, 1 tablespoon at a time, until desired consistency.",
                          tags: [],
                          instructionVideo: "https://www.youtube.com/watch?v=SamYg6IUGOI",
                          ingredients: Ingredient.previewItems,
                          source: "https://www.mythirtyspot.com/krispy-kreme-copycat-recipe-for/",
                          imageSource: nil,
                          creativeCommonsConfirmed: nil,
                          dateModified: nil)
    }
}

extension Ingredient {
    static var previewItems: [Ingredient] {
        return [Ingredient(ingredientDescription: "Yeast", measurement: "1/4 ounce"),
                Ingredient(ingredientDescription: "Water", measurement: "1/4 cup"),
                Ingredient(ingredientDescription: "Water", measurement: "1 1/2 cup"),
                Ingredient(ingredientDescription: "Sugar", measurement: "1/2 cup"),
                Ingredient(ingredientDescription: "Salt", measurement: "1 tsp"),
                Ingredient(ingredientDescription: "Eggs", measurement: "2"),
                Ingredient(ingredientDescription: "Shortening", measurement: "1/3 cup"),
                Ingredient(ingredientDescription: "Flour", measurement: "5 drops"),
                Ingredient(ingredientDescription: "Canola Oil", measurement: "Sprinking"),
                Ingredient(ingredientDescription: "Milk", measurement: "1/2 cup"),
                Ingredient(ingredientDescription: "Sugar", measurement: "2 cups"),
                Ingredient(ingredientDescription: "Vanilla", measurement: "1 1/2 cups"),
                Ingredient(ingredientDescription: "Boiling Water", measurement: "6 tablespoons"),
                Ingredient(ingredientDescription: "Butter", measurement: "1/3 cup")]
    }
}
