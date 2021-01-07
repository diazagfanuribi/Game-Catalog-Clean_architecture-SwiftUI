//
//  GameModel.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 12/11/20.
//

import Foundation

public struct GameModel: Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let rating: Double
    public let released: String
    public let background: String

    public var ratingString: String {
        return String(format: "%.2f", rating)
    }
}
