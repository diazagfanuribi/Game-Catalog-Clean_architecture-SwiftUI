//
//  File.swift
//  
//
//  Created by DiazAgfa on 05/01/21.
//

import Foundation
import Core

public struct DeveloperTransformer: Mapper{
    public func transformResponseToEntity(request: String?, response: [DeveloperResponse]) -> [DeveloperModuleEntity] {
        return response.map { result in
            let dev = DeveloperModuleEntity()
            dev.ids = result.ids ?? 0
            dev.name = result.name ?? "Unknown"
            dev.imageUrl = result.imageUrl ?? ""
            return dev
        }
    }
    
    public func transformEntityToDomain(entity: [DeveloperModuleEntity]) -> [DeveloperModel] {
        return entity.map { result in
            DeveloperModel(id: result.ids,
                           name: result.name,
                           imageUrl: result.imageUrl)
        }
    }
    
    public typealias Request = String
    
    public typealias Response = [DeveloperResponse]
    
    public typealias Entity = [DeveloperModuleEntity]
    
    public typealias Domain = [DeveloperModel]
    
    public init() {}

}
