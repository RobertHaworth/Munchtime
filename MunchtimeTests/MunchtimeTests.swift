//
//  MunchtimeTests.swift
//  MunchtimeTests
//
//  Created by Robert Haworth on 8/31/23.
//

import XCTest
@testable import Munchtime

final class MunchtimeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAllMealsResponseObject() async throws {
        let response = try await Request.sharedInstance.getAllMeals(category: "Dessert")

        // Assert there is at least 1 Dessert meal request found.
        XCTAssertGreaterThan(response.count, 0)

        guard let firstMeal = response.first else {
            XCTAssert(false, "Failure to grab first meal in the getAllMeals response")
            return
        }

        /// Meal Image and Thumbnail should not be the same.
        XCTAssertNotEqual(firstMeal.mealImage, firstMeal.mealThumbnail)

        /// Thumbnail should have the preview URI attached to it
        XCTAssertEqual(firstMeal.mealThumbnail.lastPathComponent, "preview")

        /// Thumbnail and mealImage should have identical relative paths if the preview path component is removed.
        /// Initially wanted to test for true equality, but deletingLastPathComponent is leaving the trailing / on the URL.
        XCTAssertEqual(firstMeal.mealThumbnail.deletingLastPathComponent().relativePath, firstMeal.mealImage.relativePath)
    }

    /// Long term should full mock objects, but I'd like to combine having Unit Tests engage the full network stack to trigger codable errors if API changes unexpectedly to give us a pre-warning.
    func testMealDetailResponse() async throws {

        guard let firstMeal = try await Request.sharedInstance.getAllMeals(category: "Dessert").first else {
            XCTAssert(false, "Failure to retrieve the first meal required to request meal details.")
            return
        }

        guard let mealDetail = try await Request.sharedInstance.getMealDetail(for: firstMeal.mealId) else {
            XCTAssert(false, "Failure to retrieve the details of our first meal for testing.")
            return
        }

        /// Match the initial Meal values to our details to affirm we're looking at the same object's details.
        XCTAssertEqual(firstMeal.mealId, mealDetail.mealId)
        XCTAssertEqual(firstMeal.mealName, mealDetail.mealName)
        XCTAssertEqual(firstMeal.mealImage, mealDetail.mealImage)

        /// Hooking into an unknown API, we're going to assert some hopeful statements about it...
        /// We expect at least 1 instruction to be in a meal.
        XCTAssertGreaterThan(mealDetail.ingredients.count, 0)

        /// Lets prove that all the Ingredients and Measurements are not empty.
        mealDetail.ingredients.forEach {
            XCTAssertFalse($0.ingredientDescription.isEmpty)
            XCTAssertFalse($0.measurement.isEmpty)
        }
    }
}
