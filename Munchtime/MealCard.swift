//
//  MealCard.swift
//  Munchtime
//
//  Created by Robert Haworth on 9/3/23.
//

import SwiftUI
import Kingfisher

struct MealCard: View {
    let meal: Meal

    var body: some View {
        VStack(alignment: .center) {
            KFImage(meal.mealThumbnail)
                .resizable()
                .placeholder({ _ in
                    ProgressView()
                })
            .frame(width: 100, height: 100)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(.cyan, lineWidth: 3)
            )
            .accessibilityIdentifier("imageThumbnail")

            Text(meal.mealName)
                .lineLimit(2)
                .font(.subheadline)
                .foregroundColor(.black)
                .accessibilityIdentifier("labelMealName")
        }
        .padding()
        .frame(minWidth: 150, maxWidth: 200, minHeight: 150, maxHeight: 200)
        .background(Color.green.opacity(0.2))
        .cornerRadius(16.0)
    }
}

struct MealCard_Previews: PreviewProvider {
    static var previews: some View {
        MealCard(meal: Meal.previewItem)
    }
}
