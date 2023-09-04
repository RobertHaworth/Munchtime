//
//  MealDetailView.swift
//  Munchtime
//
//  Created by Robert Haworth on 8/31/23.
//

import SwiftUI
import Kingfisher

struct MealDetailView: View {

    let meal: Meal

    @State var mealDetail: MealDetail?

    var body: some View {
        ScrollView {
            VStack {
                if let mealDetail {
                    KFImage(meal.mealImage).resizable()
                        .placeholder({ ProgressView() })
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(16.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(.cyan, lineWidth: 3)
                        )
                        .padding()
                        .frame(width: UIScreen.main.bounds.width / 2)
                        .background(Color.green.opacity(0.3))
                        .cornerRadius(16.0)


                    MealIngredientView(ingredients: mealDetail.ingredients)

                    MealInstructionView(instructions: mealDetail.instructions,
                                        instructionVideo: mealDetail.instructionVideo)
                } else {
                    VStack {
                        Text("Loading Details")
                        ProgressView()
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(meal.mealName)
                        .font(.headline)
                        .lineLimit(2)
                    if let mealDetail {
                        Text(mealDetail.locale + " " + mealDetail.category)
                            .font(.subheadline)
                    }
                }
            }
        }
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

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MealDetailView(meal: Meal.previewItem,
                           mealDetail: MealDetail.previewItem)
        }
    }
}
