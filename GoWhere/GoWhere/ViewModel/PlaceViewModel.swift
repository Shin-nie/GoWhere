//
//  PlaceViewModel.swift
//  GoWhere
//
//  Created by Hang Vu on 27/9/2024.
//
//  MARK: The PlaceViewModel is responsible for the state of selectedTab and provides the correct place data for the view based on the selected tab.


import SwiftUI

class PlaceViewModel: ObservableObject {
    
    //  MARK: - PROPERTITIES
    
    @Published var selectedTab: Int = 0 // Manages the TabSelectionView ("For You", "Updated", "Saved")

    //  MARK: Data for the SampleCardView based on selectedTab
    private let places: [Place] = [
            Place(title: "Explore Uluru", description: "A unique blend of culture, cuisine and nature. Perfect for foodies and wine enthusiasts.", imageName: "Uluru"),
            Place(title: "Explore Sonoma", description: "A unique blend of culture, cuisine and nature. Perfect for foodies and wine enthusiasts.", imageName: "Sonoma"),
            Place(title: "Explore Bali", description: "A tropical paradise with pristine beaches and cultural richness.", imageName: "Bali")
        ]
    
    //  MARK: - FUNCTIONs
    // Method to get the current place based on selected tab
       func currentPlace() -> Place {
           return places[selectedTab]
       }
}
