//
//  DeveloperMapper.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import Foundation

final class Mapper {
    static func mapDeveloperResponsesToDomains(
      input developerResponses: [DeveloperResponse]
    ) -> [DeveloperModel] {

      return developerResponses.map { result in
        return DeveloperModel(
          id: result.id ?? 0,
          name: result.name ?? "Unknow",
          imageUrl: result.imageUrl ?? "Unknow"
        )
      }
    }
    
    static func mapGameResponsesToDomains(
        input gameResponse: [GameResponse]
    )-> [GameModel]{
        
        return gameResponse.map{ result in
            return GameModel(id: result.id ?? 0, name: result.name ?? "Unknown", rating: result.rating ?? 0, released: result.released ?? "", background: result.background ?? "")
        }
    }
}
