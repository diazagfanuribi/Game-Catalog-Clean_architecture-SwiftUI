//
//  DevelopersResponse.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import Foundation

struct DevelopersResponse : Decodable{
    let results : [DeveloperResponse]
}

struct DeveloperResponse: Decodable {
    let id : Int?
    let name : String?
    let imageUrl: String?
    
    private enum CodingKeys : String,CodingKey{
        case id = "id"
        case name = "name"
        case imageUrl = "image_background"
    }
}


