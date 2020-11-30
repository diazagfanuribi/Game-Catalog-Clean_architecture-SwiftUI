//
//  GameDetailModel.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 18/11/20.
//

import Foundation

struct GameDetailModel: Equatable, Identifiable {
    let id : Int
    let name : String
    let rating : Double
    let released : String
    let background: String
    let description: String
    let backgroundAdditional: String
    let website : String
    
    var ratingRound : Double{
        guard rating == 0 else {
            return Double(round(100*rating)/100)
        }
        return rating
    }
}
