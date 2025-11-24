//  HomeView.swift
//  Lugares
//
//  Created by SaucyBreeze under the Nova Cloud Entertainment project.
//
import SwiftUI

struct HomeView: View {
    @State private var city: String = ""
    @State private var isNavigatingToFoodSelection: Bool = false
    @State private var selectedGenre: String = ""

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 40) {
                Text("Lugares")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.white)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))

                    TextField("Enter a city", text: $city)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                        .autocapitalization(.words)
                }
                .padding(.horizontal, 30)

                Button(action: {
                    isNavigatingToFoodSelection = true
                }) {
                    Text("Let's Go")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .foregroundColor(.white)
                }
                .padding()
                .disabled(city.isEmpty)
            }
        }
        .fullScreenCover(isPresented: $isNavigatingToFoodSelection) {
            FoodSelectionView(city: city, selectedGenre: $selectedGenre)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
