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
        Place(title: "Explore Uluru", description: "Australia's Iconic Rock", imageName: "Uluru"),
        Place(title: "Vietnam's Secrets", description: "A unique blend of culture, cuisine and nature. Perfect for foodies and wine enthusiasts.", imageName: "GoldenBridge"),
        Place(title: "Explore Yosemite", description: "A tropical paradise with pristine beaches and cultural richness.", imageName: "Yosemite")
    ]
    
    //  MARK: - FUNCTIONs
    // Method to get the current place based on selected tab
    func getCurrentPlace() -> Place {
        return places[selectedTab]
    }
}


//  MARK: - The FeaturedCardViewModel will be responsible for providing the data needed for the FeaturedCardView.
import SwiftUI

class FeaturedCardViewModel: ObservableObject {
    
    //  MARK: - PROPERTITIES
    @Published var selectedFeaturedTab: Int = 0 // Handle tab selection - TabView
    // Manages the horizontal card scrolling (TabView of FeaturedCardView)
    
    @Published var featuredPlaces: [FeaturedPlace] = [
        FeaturedPlace(title: "Vietnam's Secrets", subtitle: "A Wonderful Place", imageName: "GoldenBridge"),
        FeaturedPlace(title: "Discovering Yosemite", subtitle: "California's Wonder", imageName: "Yosemite"),
        FeaturedPlace(title: "Explore Uluru", subtitle: "Australia's Iconic Rock", imageName: "Uluru")
    ]
    
    //  MARK: - FUNCTIONs
    func getFeaturedPlace(for index: Int) -> FeaturedPlace {
        return featuredPlaces[index]
    }
    
    // Auto-scroll logic can also be moved here if needed
    func incrementSelectedTab() {
        selectedFeaturedTab = (selectedFeaturedTab + 1) % featuredPlaces.count // % 3
        // Automatically switch between tab - then Loop back to the first tab
        //  MARK: This ensures that when selectedFeaturedTab reaches 2 (the last tab), the next increment will loop it back to 0
    }
}


