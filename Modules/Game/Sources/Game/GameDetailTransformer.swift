//
//  File.swift
//  
//
//  Created by DiazAgfa on 05/01/21.
//

import Foundation
import Core

public struct GameDetailTransformer : Mapper{
    public func transformResponseToEntity(request: String?, response: GameDetailResponse) -> GameDetailModuleEntity {
        print("Transformer")
        print("Transformer :  \(response)")
        let det = GameDetailModuleEntity()
        det.ids = response.ids ?? 0
        det.name = response.name ?? "Unknown"
        det.rating = response.rating ?? 0
        det.desc = response.description ?? ""
        det.website = response.website ?? ""
        det.released = response.released ?? ""
        det.background = response.background ?? ""
        det.backgroundAdditional = response.backgroundAdditional ?? ""
        return det
    }
    
    public func transformEntityToDomain(entity: GameDetailModuleEntity) -> GameDetailModel {
        print("Transformer to Entity:  \(entity.desc)")
        return GameDetailModel(id: entity.ids,
         name: entity.name,
         rating: entity.rating,
         released: entity.released,
         background: entity.background,
         description: entity.desc,
         backgroundAdditional: entity.backgroundAdditional,
         website: entity.website,
         favorite: entity.favorite)
    }
    
    public typealias Request = String
    
    public typealias Response = GameDetailResponse
    
    public typealias Entity = GameDetailModuleEntity
    
    public typealias Domain = GameDetailModel
    
    public init() {}

}
