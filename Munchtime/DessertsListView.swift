//
//  ContentView.swift
//  Munchtime
//
//  Created by Robert Haworth on 8/31/23.
//

import SwiftUI
import Kingfisher

struct DessertsListView: View {

    @State var meals: [Meal] = []
    @State var error: Error?
    @State var shouldDisplayError: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.fixed(175)), GridItem(.fixed(175))]) {
                    ForEach(meals) { meal in
                        NavigationLink(value: meal) {
                            MealCard(meal: meal)
                        }
                    }
                }
            }
            .refreshable {
                getDesserts()
            }
            .navigationDestination(for: Meal.self, destination: { meal in
                MealDetailView(meal: meal)
            })
            .overlay(VStack {
                if meals.isEmpty {
                    HStack {
                        Text("Unable to load desserts at this time, pull to refresh.")
                    }
                    .padding(.horizontal, 16.0)
                    Spacer()
                }


            })

            .onAppear {
                getDesserts()
            }
            .navigationTitle(Text("Munchtime Planner"))
        }
        .alert("Error Detected",
               isPresented: $shouldDisplayError,
               presenting: error,
               actions: { _ in
            Button("Retry") {
                error = nil
                getDesserts()
            }

            Button("Cancel") {
                error = nil
            }
        }) { error in
            Text("Failure to load desserts with error: \(error.localizedDescription)")
        }
    }

    @MainActor
    func getDesserts() {
        Task {
            do {
                meals = try await Request.sharedInstance.getAllMeals(category: "Dessert")
            } catch {
                self.error = error
                self.shouldDisplayError = true
            }
        }
    }
}

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

            Text(meal.mealName)
                .lineLimit(2)
                .font(.subheadline)
                .foregroundColor(.black)
        }
        .padding()
        .frame(minWidth: 150, maxWidth: 200, minHeight: 150, maxHeight: 200)
        .background(Color.green.opacity(0.2))
        .cornerRadius(16.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DessertsListView()
    }
}

struct MealCard_Previews: PreviewProvider {
    static var previews: some View {
        MealCard(meal: Meal.previewItem)
    }
}
