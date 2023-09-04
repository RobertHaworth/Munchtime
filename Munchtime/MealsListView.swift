//
//  ContentView.swift
//  Munchtime
//
//  Created by Robert Haworth on 8/31/23.
//

import SwiftUI
import Kingfisher

struct MealsListView: View {

    @State var meals: [Meal] = []
    @State var error: Error?
    @State var shouldDisplayError: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(meals) { meal in
                        NavigationLink(value: meal) {
                            MealCard(meal: meal)
                        }.accessibilityIdentifier("MealNavigation")
                    }
                }
                .padding(8)
                .accessibilityIdentifier("GridView")
            }
            .refreshable {
                getDesserts()
            }
            .navigationDestination(for: Meal.self,
                                   destination: { meal in
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
                meals = try await Request.sharedInstance.getAllMeals(category: "Dessert").sorted()
            } catch {
                self.error = error
                self.shouldDisplayError = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MealsListView()
    }
}
