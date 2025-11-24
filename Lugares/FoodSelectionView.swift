//  FoodSelectionView.swift
//  Lugares
//
//  Created by SaucyBreeze under the Nova Cloud Entertainment project.
//
import SwiftUI

struct FoodSelectionView: View {
    var city: String
    @Binding var selectedGenre: String

    let genres = ["BBQ", "Burgers", "Chicken", "Italian", "Mexican", "Pizza", "Steak", "Tacos"]
    @State private var isNavigatingToRandomFoodSelection = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("What we craving??")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()

                ForEach(genres, id: \.self) { genre in
                    Button(action: {
                        selectedGenre = genre
                        isNavigatingToRandomFoodSelection = true
                    }) {
                        Text(genre)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    }
                    .background(selectedGenre == genre ? Color.blue.opacity(0.4) : Color.clear)  // Highlight selected genre
                }
            }
        }
        .fullScreenCover(isPresented: $isNavigatingToRandomFoodSelection) {
            RandomFoodSelectionView(city: city, genre: selectedGenre)
        }
    }
}

struct FoodSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        FoodSelectionView(city: "Austin, TX", selectedGenre: .constant("Mexican"))
    }
}
