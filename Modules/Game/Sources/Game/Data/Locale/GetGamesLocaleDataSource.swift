//
//  File.swift
//  
//
//  Created by DiazAgfa on 04/01/21.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetGamesLocaleDataSource : LocaleDataSource{
    public func list(request: String?) -> AnyPublisher<[[GameModuleEntity]], Error> {
        fatalError()
    }
    
    public func add(entities: [[GameModuleEntity]]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: String) -> AnyPublisher<[GameModuleEntity], Error> {
        fatalError()
    }
    
    public func update(id: Int, entity: [GameModuleEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public typealias Request = String
    
    public typealias Response = [GameModuleEntity]
    
    
}
