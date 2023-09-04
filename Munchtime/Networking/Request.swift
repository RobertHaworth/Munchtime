//
//  Request.swift
//  Munchtime
//
//  Created by Robert Haworth on 8/31/23.
//

import Foundation

enum RequestError: Error {
    case urlCreationFailure
}

class Request {

    private var session = URLSession(configuration: URLSessionConfiguration.default)

    private static let urlString = "https://www.themealdb.com/api/json"
    private static let apiVersion = "/v1"
    private static let apiKey = "/1"

    private let decoder = JSONDecoder()

    private var url: URL? = {
        return URL(string: urlString + apiVersion + apiKey)
    }()

    static var sharedInstance: Request {
        return Request()
    }

    func getAllMeals(category: String? = nil) async throws -> [Meal] {
        guard var componentURL = url?.appending(path: "/filter.php") else { throw RequestError.urlCreationFailure }

        if let category {
            componentURL = componentURL.appending(queryItems: [URLQueryItem(name: "c", value: category)])
        }
        let (data, _) = try await Request.sharedInstance.session.data(from: componentURL)

        return try decode(type: MealsResponse.self, data: data).meals
    }

    func getMealDetail(for mealId: String) async throws -> MealDetail? {
        guard var componentURL = url?.appending(path: "/lookup.php") else { throw RequestError.urlCreationFailure }

        componentURL = componentURL.appending(queryItems: [URLQueryItem(name: "i", value: mealId)])
        let (data, _) = try await Request.sharedInstance.session.data(from: componentURL)

        return try decode(type: MealDetailResponse.self, data: data).meals.first?.convert()
    }

    private func decode<T: Decodable>(type: T.Type, data: Data) throws -> T {
        return try decoder.decode(type, from: data)
    }
}
