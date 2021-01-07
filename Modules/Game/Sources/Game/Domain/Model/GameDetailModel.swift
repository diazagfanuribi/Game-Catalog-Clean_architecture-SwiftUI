//
//  GameDetailModel.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 18/11/20.
//

import Foundation

public struct GameDetailModel: Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let rating: Double
    public let released: String
    public let background: String
    public let description: String
    public let backgroundAdditional: String
    public let website: String
    public let favorite: Bool

    public var ratingString: String {
        return String(format: "%.2f", rating)
    }
    
    public init(id: Int, name: String,rating: Double, released: String,background: String, description: String,backgroundAdditional: String, website: String , favorite: Bool){
        self.id = id
        self.name = name
        self.rating = rating
        self.released = released
        self.background = background
        self.description = description
        self.backgroundAdditional = backgroundAdditional
        self.website = website
        self.favorite = favorite
    }
}
