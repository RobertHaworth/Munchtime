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
            List(meals) { meal in
                NavigationLink(value: meal) {
                    MealCard(meal: meal)
                }
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
            .refreshable {
                getDesserts()
            }
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
                meals = try await Request.sharedInstance.getAllDesserts()
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
        HStack {
            KFImage(meal.mealThumbnail)
                .resizable()
                .placeholder({ _ in
                    ProgressView()
                })
            .frame(width: 50, height: 50)
            Text(meal.mealName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DessertsListView()
    }
}
