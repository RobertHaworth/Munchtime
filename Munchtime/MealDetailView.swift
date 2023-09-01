//
//  MealDetailView.swift
//  Munchtime
//
//  Created by Robert Haworth on 8/31/23.
//

import SwiftUI

struct MealDetailView: View {

    let meal: Meal

    @State var mealDetail: MealDetail?

    var body: some View {

        VStack {
            if let mealDetail {
                MealDetailCardView(detailView: mealDetail)
                MealIngredientView(ingredients: mealDetail.ingredients,
                                   measurements: mealDetail.measurements)
                Spacer()
            } else {
                VStack {
                    Text("Loading Details")
                }
            }
        }
        .navigationTitle(Text(meal.mealName))
        .onAppear {
            loadDetails()
        }
    }

    @MainActor
    func loadDetails() {
        Task {
            do {
                mealDetail = try await Request.sharedInstance.getMealDetail(for: meal.id)
            } catch  {
                print(error)
            }
        }

    }
}

struct MealIngredientView: View {
    let ingredients: Array<String>
    let measurements: Array<String>

    var body: some View {
        HStack {
            VStack(alignment: .trailing) {
                ForEach(ingredients.indices, id: \.self) {
                    Text(ingredients[$0])
                }
            }

            Divider()

            VStack(alignment: .leading) {
                ForEach(measurements.indices, id: \.self) {
                    Text(measurements[$0])
                }
            }
        }
    }
}

struct MealDetailCardView: View {

    let detailView: MealDetail

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Category:")
                Text(detailView.category)
            }

            HStack {
                Text("Type:")
                Text(detailView.locale)
            }
        }
        .padding()
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MealDetailView(meal: Meal.previewItem,
                           mealDetail: MealDetail.previewData)
        }
    }
}

struct MealDetailCardView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailCardView(detailView: MealDetail.previewData)
    }
}
