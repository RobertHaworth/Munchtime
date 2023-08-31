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

    private var session: URLSession = URLSession(configuration: URLSessionConfiguration.default)


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

    func getAllDesserts() async throws -> [Meal] {
        let componentURL = url?.appending(path: "/filter.php")
        guard let formedURL = componentURL?.appending(queryItems: [URLQueryItem(name: "c", value: "Dessert")]) else {
            throw RequestError.urlCreationFailure
        }

        let (data, _) = try await Request.sharedInstance.session.data(from: formedURL)

        return try decode(type: MealsResponse.self, data: data).meals
    }

    private func decode<T: Decodable>(type: T.Type, data: Data) throws -> T {
        return try decoder.decode(type, from: data)
    }
}


