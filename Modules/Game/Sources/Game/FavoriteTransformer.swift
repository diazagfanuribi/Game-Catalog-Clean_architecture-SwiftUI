//
//  File.swift
//  
//
//  Created by DiazAgfa on 05/01/21.
//

import Foundation
import Core

public struct FavoriteTransformer: Mapper{
    public func transformResponseToEntity(request: String?, response: [GameDetailModel]) -> [GameDetailModuleEntity] {
        return response.map{ result in
            let det = GameDetailModuleEntity()
            det.ids = result.id
            det.name = result.name
            det.rating = result.rating
            det.desc = result.description
            det.website = result.website
            det.released = result.released
            det.background = result.background
            det.backgroundAdditional = result.backgroundAdditional
            det.favorite = result.favorite
            return det
        }
    }
    
    public func transformEntityToDomain(entity: [GameDetailModuleEntity]) -> [GameDetailModel] {
        return entity.map{ result in
                            GameDetailModel(id: result.ids,
                             name: result.name,
                             rating: result.rating,
                             released: result.released,
                             background: result.background,
                             description: result.description,
                             backgroundAdditional: result.backgroundAdditional,
                             website: result.website,
                             favorite: result.favorite)}
    }
    
    public typealias Request = String
    
    public typealias Response = [GameDetailModel]
    
    public typealias Entity = [GameDetailModuleEntity]
    
    public typealias Domain = [GameDetailModel]
    
    public init() {}

    
}
