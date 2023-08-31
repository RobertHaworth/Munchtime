//
//  Meal.swift
//  Munchtime
//
//  Created by Robert Haworth on 8/31/23.
//

import Foundation

struct MealsResponse: Codable {
    var meals: [Meal]
}

struct Meal: Codable {
    var mealName: String
    var mealImage: URL
    var mealId: String

    var mealThumbnail: URL {
        return mealImage.appendingPathComponent("/preview")
    }

    private enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case mealImage = "strMealThumb"
        case mealId = "idMeal"
    }

    static var previewItem: Meal {
        return Meal(mealName: "Classic Cherry Pie",
                    mealImage: URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")!,
                    mealId: "0000")
    }
}

extension Meal: Identifiable {
    typealias ID = String
    var id: String { return mealId }
}

extension Meal: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(mealId)
        hasher.combine(mealName)
    }
}
