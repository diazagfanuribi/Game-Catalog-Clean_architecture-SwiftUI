//
//  DevelopersResponse.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import Foundation

public struct DevelopersResponse: Decodable {
    let results: [DeveloperResponse]
}

public struct DeveloperResponse: Decodable {
    let ids: Int?
    let name: String?
    let imageUrl: String?

    private enum CodingKeys: String, CodingKey {
        case ids = "id"
        case name = "name"
        case imageUrl = "image_background"
    }
}
