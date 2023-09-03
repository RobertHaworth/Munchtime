//
//  MealInstructionView.swift
//  Munchtime
//
//  Created by Robert Haworth on 9/3/23.
//

import SwiftUI

struct MealInstructionView: View {

    let instructions: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .underline()
                .font(.largeTitle)
                .padding(4.0)
            Text(instructions)
        }
        .padding()
        .background(Color.green.opacity(0.3))
        .cornerRadius(16.0)
    }
}

struct MealInstructionView_Previews: PreviewProvider {
    static var previews: some View {
        MealInstructionView(instructions: MealDetail.previewItem.instructions)
    }
}
