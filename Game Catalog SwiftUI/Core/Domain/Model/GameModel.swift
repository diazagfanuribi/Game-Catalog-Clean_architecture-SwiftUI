//
//  GameModel.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 12/11/20.
//

import Foundation

struct GameModel: Equatable, Identifiable {
    let id : Double
    let name : String
    let rating : Double
    let released : String
    let background: String
}
