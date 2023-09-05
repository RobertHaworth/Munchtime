//
//  MealDetailView.swift
//  Munchtime
//
//  Created by Robert Haworth on 8/31/23.
//

import Kingfisher
import SwiftUI

struct MealDetailView: View {

    let meal: Meal

    @State var mealDetail: MealDetail?
    @State var error: Error?
    @State var shouldDisplayError = false

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

                    MealSourceView(sourceURL: mealDetail.source)
                } else {
                    VStack {
                        Text("Loading Details")
                        ProgressView()
                    }
                }
            }
            .padding(.horizontal)
        }
        .refreshable {
            loadDetails()
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
        .alert("Error Detected",
               isPresented: $shouldDisplayError,
               presenting: error,
               actions: { _ in
            Button("Retry") {
                error = nil
                loadDetails()
            }

            Button("Cancel") {
                error = nil
            }
        },
               message: { error in
            Text("Failure to load desserts with error: \(error.localizedDescription)")
        })
    }

    func loadDetails() {
        Task {
            do {
                mealDetail = try await Request.sharedInstance.getMealDetail(for: meal.id)
            } catch {
                self.error = error
                shouldDisplayError = true
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
