//  RandomFoodSelectionView.swift
//  Lugares
//
//  Created by SaucyBreeze under the Nova Cloud Entertainment project.
//
import SwiftUI

struct RandomFoodSelectionView: View {
    var city: String
    var genre: String
    @State private var selection: String = ""
    @State private var isNavigatingBackToFoodSelection = false
    @State private var isNavigatingBackToHomeView = false

    let sampleDataAustin: [String: [String]] = [
        "BBQ": ["Salt Lick BBQ", "Rudy's Country Store & Bar-B-Q", "Smokey Mo's BBQ", "The Original Black's Barbecue", "Pok-e-Jo's Smokehouse", "SLAB BBQ & Beer", "Black Iron Eats", "Jim's Smokehouse", "Smoky Buns", "Hello Sweetie BBQ and More"],
        "Burgers": ["Hopdoddy Burger Bar", "Mighty Fine Burgers", "Mooyah Burgers, Fries & Shakes", "Hat Creek Burger Company", "Wayback Burgers", "Shake Shack", "Finley's Round Rock", "In n Out", "Whataburger", "P Terry's", "Burger King", "Five Guys", "WiseGuys A Chicago Eatery", "Hurricane Grill & Wings", "High Country Market", "Salt Traders Coastal Cooking", "Bar Louie", "Buddy's Burger", "Buddha Burger", "Texas Made Supply Company"],
        "Chicken": ["Whip My Soul", "Tumble 22 Chicken Joint", "Chick Fil Gay", "Bush's Chicken", "Chicken Express", "Church's Texas Chicken", "KFC", "Pollo Campero", "Popeyes Louisiana Kitchen", "Raising Cane's Chicken Fingers", "Zaxby's", "Pluckers Wing Bar", "Wingstop", "Anchor Bar", "Hurricane Grill & Wings", "Buffalo Wings & Rings", "Golden Fried Chicken", "Urban Bird Hot Chicken", "Finley's", "Golden Chick"],
        "Italian": ["Gino's Italian Restaurant", "Palermo Pasta House", "Sortino's Italian Kitchen", "Baris Pasta & Pizza", "La Cocina", "Olive Garden Italian Restaurant", "Carrabba's Italian Grill", "Mandola's Italian Restaurant", "Juliet Italian Kitchen", "Taverna - Domain Northside", "North Italia – Austin", "The Grove Wine Bar and Kitchen - Cedar Park", "La Riv - Georgetown", "Maggiano's", "Andiamo Ristorante", "Tony C's", "Brooklyn Heights Pizzeria", "Frankie's Pizza & Pasta", "Gino's Italian Cafe", "Russo's New York Pizzeria & Italian Kitchen"],
        "Mexican": ["Rosa's Café", "Santiago's Tex-Mex and Cantina", "Tequila Bar & Grill", "MasFajitas", "Lupe Tortilla", "Chuy's", "Torchy's Tacos", "Taqueria Arandinas", "Dos Salsas", "Gloria's Latin Cuisine", "El Monumento", "Tacodeli", "Taqueria Mi Tia", "Burros Tex Mex Bar and Grill", "La Texanita", "Luna's Tacos", "Casa Garcia's", "El Rinconcito", "El Mariachi", "El Pollo Rico"],
        "Pizza": ["Gino's Italian Restaurant", "Pinthouse Pizza", "Slap Box Pizzicheria", "Warpath Pints And Pizza", "Brooklyn Pie Co.", "Sortino’s Italian Kitchen", "Tony C's Pizza & Beer Garden", "Niki's Pizza", "Baris Pasta & Pizza", "Reale's Pizza & Cafe"],
        "Tacos": ["Luna's Tacos", "Torchy's Tacos", "Taco More", "Del Sol Taqueria Restaurant and Bar", "Tio Dan Café Puffy Tacos N Fish", "The Alcove Cantina", "Casa Garcia's", "Nixtamal Tacos and Drinks", "Velvet Taco", "Taco Palenque", "Tacos Kitchen", "Taqueria Mi Tia", "Taquerias Arandinas", "La Tapatia", "Regios Tacos Al Vapor", "Taqueria Quiroga Michoacán", "El Pollo Rico", "Santiago's Tex-Mex and Cantina", "MasFajitas"],
        "Steak": ["Double Cut Steak House", "Saltgrass Steak House", "LongHorn Steakhouse", "Outback Steakhouse", "Jack Allen's Kitchen", "Tokyo Steak House and Sushi Bar", "Fogueira Gaúcha Brazilian Steakhouse", "Urban Eat.Drink", "Texas Roadhouse", "City Post Chophouse"]
    ]
    let sampleDataRoundRock: [String: [String]] = [
        "BBQ": ["Salt Lick BBQ", "Rudy's Country Store & Bar-B-Q", "Smokey Mo's BBQ", "The Original Black's Barbecue", "Pok-e-Jo's Smokehouse", "SLAB BBQ & Beer", "Black Iron Eats", "Jim's Smokehouse", "Smoky Buns", "Hello Sweetie BBQ and More"],
        "Burgers": ["Hopdoddy Burger Bar", "Mighty Fine Burgers", "Mooyah Burgers, Fries & Shakes", "Hat Creek Burger Company", "Wayback Burgers", "Shake Shack", "Finley's Round Rock", "In n Out", "Whataburger", "P Terry's", "Burger King", "Five Guys", "WiseGuys A Chicago Eatery", "Hurricane Grill & Wings", "High Country Market", "Salt Traders Coastal Cooking", "Bar Louie", "Buddy's Burger", "Buddha Burger", "Texas Made Supply Company"],
        "Chicken": ["Whip My Soul", "Tumble 22 Chicken Joint", "Chick Fil Gay", "Bush's Chicken", "Chicken Express", "Church's Texas Chicken", "KFC", "Pollo Campero", "Popeyes Louisiana Kitchen", "Raising Cane's Chicken Fingers", "Zaxby's", "Pluckers Wing Bar", "Wingstop", "Anchor Bar", "Hurricane Grill & Wings", "Buffalo Wings & Rings", "Golden Fried Chicken", "Urban Bird Hot Chicken", "Finley's", "Golden Chick"],
        "Italian": ["Gino's Italian Restaurant", "Palermo Pasta House", "Sortino's Italian Kitchen", "Baris Pasta & Pizza", "La Cocina", "Olive Garden Italian Restaurant", "Carrabba's Italian Grill", "Mandola's Italian Restaurant", "Juliet Italian Kitchen", "Taverna - Domain Northside", "North Italia – Austin", "The Grove Wine Bar and Kitchen - Cedar Park", "La Riv - Georgetown", "Maggiano's", "Andiamo Ristorante", "Tony C's", "Brooklyn Heights Pizzeria", "Frankie's Pizza & Pasta", "Gino's Italian Cafe", "Russo's New York Pizzeria & Italian Kitchen"],
        "Mexican": ["Rosa's Café", "Santiago's Tex-Mex and Cantina", "Tequila Bar & Grill", "MasFajitas", "Lupe Tortilla", "Chuy's", "Torchy's Tacos", "Taqueria Arandinas", "Dos Salsas", "Gloria's Latin Cuisine", "El Monumento", "Tacodeli", "Taqueria Mi Tia", "Burros Tex Mex Bar and Grill", "La Texanita", "Luna's Tacos", "Casa Garcia's", "El Rinconcito", "El Mariachi", "El Pollo Rico"],
        "Pizza": ["Gino's Italian Restaurant", "Pinthouse Pizza", "Slap Box Pizzicheria", "Warpath Pints And Pizza", "Brooklyn Pie Co.", "Sortino’s Italian Kitchen", "Tony C's Pizza & Beer Garden", "Niki's Pizza", "Baris Pasta & Pizza", "Reale's Pizza & Cafe"],
        "Tacos": ["Luna's Tacos", "Torchy's Tacos", "Taco More", "Del Sol Taqueria Restaurant and Bar", "Tio Dan Café Puffy Tacos N Fish", "The Alcove Cantina", "Casa Garcia's", "Nixtamal Tacos and Drinks", "Velvet Taco", "Taco Palenque", "Tacos Kitchen", "Taqueria Mi Tia", "Taquerias Arandinas", "La Tapatia", "Regios Tacos Al Vapor", "Taqueria Quiroga Michoacán", "El Pollo Rico", "Santiago's Tex-Mex and Cantina", "MasFajitas"],
        "Steak": ["Double Cut Steak House", "Saltgrass Steak House", "LongHorn Steakhouse", "Outback Steakhouse", "Jack Allen's Kitchen", "Tokyo Steak House and Sushi Bar", "Fogueira Gaúcha Brazilian Steakhouse", "Urban Eat.Drink", "Texas Roadhouse", "City Post Chophouse"]
    ]
    let sampleDataGeorgetown: [String: [String]] = [
        "BBQ": ["Salt Lick BBQ", "Rudy's Country Store & Bar-B-Q", "Smokey Mo's BBQ", "The Original Black's Barbecue", "Pok-e-Jo's Smokehouse", "SLAB BBQ & Beer", "Black Iron Eats", "Jim's Smokehouse", "Smoky Buns", "Hello Sweetie BBQ and More"],
        "Burgers": ["Hopdoddy Burger Bar", "Mighty Fine Burgers", "Mooyah Burgers, Fries & Shakes", "Hat Creek Burger Company", "Wayback Burgers", "Shake Shack", "Finley's Round Rock", "In n Out", "Whataburger", "P Terry's", "Burger King", "Five Guys", "WiseGuys A Chicago Eatery", "Hurricane Grill & Wings", "High Country Market", "Salt Traders Coastal Cooking", "Bar Louie", "Buddy's Burger", "Buddha Burger", "Texas Made Supply Company"],
        "Chicken": ["Whip My Soul", "Tumble 22 Chicken Joint", "Chick Fil Gay", "Bush's Chicken", "Chicken Express", "Church's Texas Chicken", "KFC", "Pollo Campero", "Popeyes Louisiana Kitchen", "Raising Cane's Chicken Fingers", "Zaxby's", "Pluckers Wing Bar", "Wingstop", "Anchor Bar", "Hurricane Grill & Wings", "Buffalo Wings & Rings", "Golden Fried Chicken", "Urban Bird Hot Chicken", "Finley's", "Golden Chick"],
        "Italian": ["Gino's Italian Restaurant", "Palermo Pasta House", "Sortino's Italian Kitchen", "Baris Pasta & Pizza", "La Cocina", "Olive Garden Italian Restaurant", "Carrabba's Italian Grill", "Mandola's Italian Restaurant", "Juliet Italian Kitchen", "Taverna - Domain Northside", "North Italia – Austin", "The Grove Wine Bar and Kitchen - Cedar Park", "La Riv - Georgetown", "Maggiano's", "Andiamo Ristorante", "Tony C's", "Brooklyn Heights Pizzeria", "Frankie's Pizza & Pasta", "Gino's Italian Cafe", "Russo's New York Pizzeria & Italian Kitchen"],
        "Mexican": ["Rosa's Café", "Santiago's Tex-Mex and Cantina", "Tequila Bar & Grill", "MasFajitas", "Lupe Tortilla", "Chuy's", "Torchy's Tacos", "Taqueria Arandinas", "Dos Salsas", "Gloria's Latin Cuisine", "El Monumento", "Tacodeli", "Taqueria Mi Tia", "Burros Tex Mex Bar and Grill", "La Texanita", "Luna's Tacos", "Casa Garcia's", "El Rinconcito", "El Mariachi", "El Pollo Rico"],
        "Pizza": ["Gino's Italian Restaurant", "Pinthouse Pizza", "Slap Box Pizzicheria", "Warpath Pints And Pizza", "Brooklyn Pie Co.", "Sortino’s Italian Kitchen", "Tony C's Pizza & Beer Garden", "Niki's Pizza", "Baris Pasta & Pizza", "Reale's Pizza & Cafe"],
        "Tacos": ["Luna's Tacos", "Torchy's Tacos", "Taco More", "Del Sol Taqueria Restaurant and Bar", "Tio Dan Café Puffy Tacos N Fish", "The Alcove Cantina", "Casa Garcia's", "Nixtamal Tacos and Drinks", "Velvet Taco", "Taco Palenque", "Tacos Kitchen", "Taqueria Mi Tia", "Taquerias Arandinas", "La Tapatia", "Regios Tacos Al Vapor", "Taqueria Quiroga Michoacán", "El Pollo Rico", "Santiago's Tex-Mex and Cantina", "MasFajitas"],
        "Steak": ["Double Cut Steak House", "Saltgrass Steak House", "LongHorn Steakhouse", "Outback Steakhouse", "Jack Allen's Kitchen", "Tokyo Steak House and Sushi Bar", "Fogueira Gaúcha Brazilian Steakhouse", "Urban Eat.Drink", "Texas Roadhouse", "City Post Chophouse"]
    ]
    func randomPlace() {
        var selectedSampleData: [String: [String]] = [
            "TMP": ["Code had an oopsie", "This is a FEATURE NOT BUG..."]]

        // Select the city-specific sample data
        switch city {
        case "Austin":
            selectedSampleData = sampleDataAustin
        case "Round Rock":
            selectedSampleData = sampleDataRoundRock
        case "Georgetown":
            selectedSampleData = sampleDataGeorgetown
        default:
            selection = "City Coming Soon..."
            return
        }
        
        if let options = selectedSampleData[genre] {
            if !options.isEmpty {
                // Generate a random index between 0 and options.count - 1
                let randomIndex = Int.random(in: 0..<options.count)
                selection = options[randomIndex]
            } else {
                selection = "Bruh choose a place..."
            }
            //selection = options.randomElement() ?? "Bruh choose a place..."
        } else {
            selection = "Code had an oopsies"
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

                Text(selection.isEmpty ? "Loading..." : selection)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding()

                Button(action: {
                    randomPlace()
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
            randomPlace()
        }
        .fullScreenCover(isPresented: $isNavigatingBackToFoodSelection) {
            FoodSelectionView(city: city, selectedGenre: .constant(genre))
        }
        .fullScreenCover(isPresented: $isNavigatingBackToHomeView) {
            HomeView()
        }
    }
}

struct RandomFoodSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RandomFoodSelectionView(city: "Austin", genre: "Tacos")
    }
}
