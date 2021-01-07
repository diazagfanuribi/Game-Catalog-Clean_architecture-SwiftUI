//
//  GamesResponse.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import Foundation

public struct GamesResponse: Decodable {
    let results: [GameResponse]

}

public struct GameResponse: Decodable {
    let ids: Int?
    let name: String?
    let rating: Double?
    let released: String?
    let background: String?

    private enum CodingKeys: String, CodingKey {
        case ids = "id"
        case name = "name"
        case rating = "rating"
        case released = "released"
        case background = "background_image"
    }

}
