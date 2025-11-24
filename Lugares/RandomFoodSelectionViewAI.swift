//  RandomFoodSelectionView.swift
//  Lugares
//
//  Created by SaucyBreeze under the Nova Cloud Entertainment project.

import SwiftUI

struct RandomFoodSelectionView: View {
    var city: String
    var genre: String

    @State private var selection: String = "Loading..."
    @State private var isNavigatingBackToFoodSelection = false
    @State private var isNavigatingBackToHomeView = false
    @State private var isLoading = false

    func fetchAIRecommendation(city: String, genre: String) async {
        isLoading = true
        defer { isLoading = false }

        let prompt = """
        Give me 10 real restaurants in \(city), Texas that fit the category: \(genre). 
        Respond ONLY as a JSON array of strings. Example:
        ["Place 1", "Place 2", ...]
        """

        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            selection = "Invalid API URL"
            return
        }

        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.7
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(OpenAIConfig.apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            if let response = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let choices = response["choices"] as? [[String: Any]],
               let message = choices.first?["message"] as? [String: Any],
               let content = message["content"] as? String {

                if let jsonData = content.data(using: .utf8),
                   let restaurants = try? JSONDecoder().decode([String].self, from: jsonData),
                   let randomChoice = restaurants.randomElement()
                {
                    selection = randomChoice
                } else {
                    selection = "Incorrect choice"
                }

            } else {
                selection = "Invalid response"
            }

        } catch {
            selection = "Network error"
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Text("In \(city), we feasting at:")
                    .font(.headline)
                    .foregroundColor(.white)

                Text(selection)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding()

                if isLoading {
                    ProgressView()
                        .tint(.white)
                }

                Button(action: {
                    Task { await fetchAIRecommendation(city: city, genre: genre) }
                }) {
                    Text("Pick Again")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }

                Button(action: {
                    isNavigatingBackToFoodSelection = true
                }) {
                    Text("Back to Food Selection")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }

                Button(action: {
                    isNavigatingBackToHomeView = true
                }) {
                    Text("Back to Home")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.5))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
            }
            .padding()
        }
        .onAppear {
            Task { await fetchAIRecommendation(city: city, genre: genre) }
        }
        .fullScreenCover(isPresented: $isNavigatingBackToFoodSelection) {
            FoodSelectionView(city: city, selectedGenre: .constant(genre))
        }
        .fullScreenCover(isPresented: $isNavigatingBackToHomeView) {
            HomeView()
        }
    }
}
