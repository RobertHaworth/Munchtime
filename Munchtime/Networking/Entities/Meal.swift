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
}

extension Meal: Comparable {
    static func < (lhs: Meal, rhs: Meal) -> Bool {
        return lhs.mealName < rhs.mealName
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
