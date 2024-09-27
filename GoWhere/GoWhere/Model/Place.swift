//
//  Place.swift
//  GoWhere
//
//  Created by Hang Vu on 27/9/2024.
//  MARK: The Place model represents tourist destinations and attractions, with data like title, description, and imageName.

import Foundation
//  Since both "PlaceCardView" and "FeaturedCardView" share common data attributes (like title, imageName), so create a protocol for the data model that defines this structure.
//  This will ensure consistent behavior for all places.

//  MARK: - Protocol for Place Data
protocol PlaceDataProtocol: Codable {
    var title: String { get }
    var imageName: String { get }
}

//  MARK: - Protocol for Featured Place Data
protocol FeaturedPlaceProtocol: PlaceDataProtocol {
    var subtitle: String { get }
}

//  MARK: - Place Model
struct Place: PlaceDataProtocol {
    var title: String
    var description: String //  additional info
    var imageName: String
}

//  MARK: - Featured Place Model
struct FeaturedPlace: FeaturedPlaceProtocol {
    var title: String
    var subtitle: String // Must have base on the FeaturedCardDataProtocol
    var imageName: String
}


