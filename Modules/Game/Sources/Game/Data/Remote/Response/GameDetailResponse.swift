//
//  GameDetailResponse.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 18/11/20.
//

import Foundation

public struct GameDetailResponse: Decodable {
    let ids: Int?
    let name: String?
    let rating: Double?
    let released: String?
    let background: String?
    let description: String?
    let backgroundAdditional: String?
    let website: String?

    private enum CodingKeys: String, CodingKey {
        case ids = "id"
        case name = "name"
        case rating = "rating"
        case released = "released"
        case background = "background_image"
        case description = "description_raw"
        case backgroundAdditional = "background_image_additional"
        case website

    }

}
