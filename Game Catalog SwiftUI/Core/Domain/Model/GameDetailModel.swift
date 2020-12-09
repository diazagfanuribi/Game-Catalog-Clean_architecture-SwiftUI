//
//  GameDetailModel.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 18/11/20.
//

import Foundation

struct GameDetailModel: Equatable, Identifiable {
    let id: Int
    let name: String
    let rating: Double
    let released: String
    let background: String
    let description: String
    let backgroundAdditional: String
    let website: String
    let favorite: Bool

    var ratingString: String {
        return String(format: "%.2f", rating)
    }
}
