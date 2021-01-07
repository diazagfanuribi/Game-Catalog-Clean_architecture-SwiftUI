//
//  File.swift
//  
//
//  Created by DiazAgfa on 05/01/21.
//

import Foundation
import Core

public struct GamesTransformer: Mapper{
    public func transformResponseToEntity(request: String?, response: [GameResponse]) -> [GameModuleEntity] {
        return response.map { result in
            let gameEntity = GameModuleEntity()
            gameEntity.ids = result.ids ?? 0
            gameEntity.name = result.name ?? "Unknown"
            gameEntity.rating = result.rating ?? 0
            gameEntity.released = result.released ?? "-"
            gameEntity.background = result.background ?? ""
            return gameEntity
        }
    }
    
    public func transformEntityToDomain(entity: [GameModuleEntity]) -> [GameModel] {
        return entity.map { result in
            GameModel(id: result.ids,
                      name: result.name,
                      rating: result.rating,
                      released: result.released,
                      background: result.background)
        }
    }
    
    public typealias Request = String
    
    public typealias Response = [GameResponse]
    
    public typealias Entity = [GameModuleEntity]
    
    public typealias Domain = [GameModel]
        
    public init() {}

}
