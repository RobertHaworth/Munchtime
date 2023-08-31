//
//  MealDetailView.swift
//  Munchtime
//
//  Created by Robert Haworth on 8/31/23.
//

import SwiftUI

struct MealDetailView: View {

    let meal: Meal 
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(meal: Meal.previewItem)
    }
}
