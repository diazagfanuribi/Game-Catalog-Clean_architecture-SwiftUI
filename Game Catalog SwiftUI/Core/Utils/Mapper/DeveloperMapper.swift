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
          id: result.ids ?? 0,
          name: result.name ?? "Unknow",
          imageUrl: result.imageUrl ?? "Unknow"
        )
      }
    }

    static func mapGameResponsesToDomains(
        input gameResponse: [GameResponse]
    ) -> [GameModel] {

        return gameResponse.map { result in
            return GameModel(id: result.ids ?? 0,
                             name: result.name ?? "Unknown",
                             rating: result.rating ?? 0,
                             released: result.released ?? "-",
                             background: result.background ?? "")
        }
    }

    static func mapGameDetailResponseToDomain(
        input response: GameDetailResponse
    ) -> GameDetailModel {

        return GameDetailModel(id: response.ids ?? 0,
           name: response.name ?? "Unknown",
           rating: response.rating ?? 0,
           released: response.released ?? "-",
           background: response.background ?? "",
           description: response.description ?? "",
           backgroundAdditional: response.backgroundAdditional ?? "",
           website: response.website ?? "Unknown",
           favorite: false)
    }

    static func mapGameEntityToDomain(input game: [GameEntity]) -> [GameModel] {
        return game.map { result in
            GameModel(id: result.ids,
                      name: result.name,
                      rating: result.rating,
                      released: result.released,
                      background: result.background)
        }
    }
    static func mapGameDomaintoEntity(input game: [GameModel]) -> [GameEntity] {
        return game.map { result in
            let gameEntity = GameEntity()
            gameEntity.ids = result.id
            gameEntity.name = result.name
            gameEntity.rating = result.rating
            gameEntity.released = result.released
            gameEntity.background = result.background
            return gameEntity
        }
    }
    static func mapDeveloperEntityToDomain(input developer: [DeveloperEntity]) -> [DeveloperModel] {
        return developer.map { result in
            DeveloperModel(id: result.ids,
                           name: result.name,
                           imageUrl: result.imageUrl)
        }
    }
    static func mapDeveloperDomaintoEntity(input developer: [DeveloperModel]) -> [DeveloperEntity] {
        return developer.map { result in
            let dev = DeveloperEntity()
            dev.ids = result.id
            dev.name = result.name
            dev.imageUrl = result.imageUrl
            return dev
        }
    }
    static func mapGameDetailEntityToDomain(input detail: GameDetailEntity) -> GameDetailModel {
        return GameDetailModel(id: detail.ids,
         name: detail.name,
         rating: detail.rating,
         released: detail.released,
         background: detail.background,
         description: detail.desc,
         backgroundAdditional: detail.backgroundAdditional,
         website: detail.website,
         favorite: detail.favorite)
    }

    static func mapGameDetailDomainToEntity(input detail: GameDetailModel) -> GameDetailEntity {
        let det = GameDetailEntity()
        det.ids = detail.id
        det.name = detail.name
        det.rating = detail.rating
        det.desc = detail.description
        det.website = detail.website
        det.released = detail.released
        det.background = detail.background
        det.backgroundAdditional = detail.backgroundAdditional
        det.favorite = detail.favorite
        return det
    }
}
