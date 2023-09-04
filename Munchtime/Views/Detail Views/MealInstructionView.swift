//
//  MealInstructionView.swift
//  Munchtime
//
//  Created by Robert Haworth on 9/3/23.
//

import SwiftUI

struct MealInstructionView: View {

    let instructions: String
    let instructionVideo: String?

    var body: some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .underline()
                .font(.largeTitle)
                .padding(.bottom, 4.0)
            if let instructionVideo,
               let url = URL(string: instructionVideo) {
                Button(action: {
                    UIApplication.shared.open(url)
                }, label: {
                    Text("Video Instructions")
                        .underline()
                })
                .padding(.bottom, 4)
            }

            Text(instructions)
        }
        .padding()
        .background(Color.green.opacity(0.3))
        .cornerRadius(16.0)
    }
}

struct MealInstructionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MealInstructionView(instructions: MealDetail.previewItem.instructions,
                                instructionVideo: nil)
            MealInstructionView(instructions: MealDetail.previewItem.instructions,
                                instructionVideo: "https://www.youtube.com/watch?v=SamYg6IUGOI")
        }
    }
}
