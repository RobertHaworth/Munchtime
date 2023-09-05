//
//  MealSourceView.swift
//  Munchtime
//
//  Created by Robert Haworth on 9/4/23.
//

import SwiftUI

struct MealSourceView: View {

    let sourceURL: String?

    var body: some View {
        HStack(alignment: .top) {
            Text("Source Video:")
                .font(.title2)
                .padding(.bottom, 4.0)
            if let sourceURL,
               let url = URL(string: sourceURL) {
                Button(action: {
                    UIApplication.shared.open(url)
                }, label: {
                    Text("Click Here")
                        .font(.title2)
                })
                .padding(.bottom, 4)
            } else {
                Text("Not Available")
                    .foregroundColor(.gray)
                    .font(.title2)
                    .italic()
            }
            Spacer()
        }
        .padding()
        .background(Color.green.opacity(0.3))
        .cornerRadius(16.0)
    }
}

struct MealSourceView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MealSourceView(sourceURL: nil)
            MealSourceView(sourceURL: "https://www.google.com")
        }
    }
}
