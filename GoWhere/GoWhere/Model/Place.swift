//
//  Place.swift
//  GoWhere
//
//  Created by Hang Vu on 27/9/2024.
//  MARK: The Place model represents tourist destinations and attractions, with data like title, description, and imageName.

import Foundation

//  MARK: - Protocol for Place Data
//  This will ensure consistent behavior for all places.

protocol PlaceDataProtocol: Codable {
    var title: String { get }
    var description: String { get }
    var imageName: String { get }
}

//  MARK: - Place Model
struct Place: PlaceDataProtocol {
    var title: String
    var description: String
    var imageName: String
}
