//
//  MealIngredientView.swift
//  Munchtime
//
//  Created by Robert Haworth on 9/3/23.
//

import SwiftUI

struct MealIngredientView: View {
    let ingredients: [Ingredient]

    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Ingredients")
                        .font(.title)
                        .underline()
                        .padding(.bottom, 4)
                        .scaledToFit()
                    ForEach(ingredients) { ingredient in
                        Text(ingredient.ingredientDescription)
                    }
                }

                Divider()
                    .background(Color.black)

                VStack(alignment: .leading) {
                    Text("Quantity")
                        .font(.title)
                        .underline()
                        .padding(.bottom, 4)
                        .scaledToFit()
                    ForEach(ingredients) { ingredient in
                        Text(ingredient.measurement)
                    }
                }
                Spacer()
            }
        }
        .padding()
        .background(Color.green.opacity(0.3))
        .cornerRadius(16.0)
    }
}

struct MealIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        MealIngredientView(ingredients: Ingredient.previewItems)
            .previewLayout(.sizeThatFits)
    }
}
