//
//  File.swift
//  
//
//  Created by DiazAgfa on 05/01/21.
//

import Core
import Combine
import RealmSwift
import Foundation
public struct GetGameDetailLocaleDataSource : LocaleDataSource {
    public func list(request: Int?) -> AnyPublisher<[GameDetailModuleEntity], Error> {
        fatalError()
    }
    
    public func add(entities: [GameDetailModuleEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
                do {
                    try _realm.write {
                        _realm.add(entities, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
        }.eraseToAnyPublisher()
    }
    public func get(id: Int) -> AnyPublisher<GameDetailModuleEntity, Error> {
        return Future<GameDetailModuleEntity, Error> { completion in
                let details: GameDetailModuleEntity? = {
                    _realm.object(ofType: GameDetailModuleEntity.self, forPrimaryKey: id)
                }()
                guard let detail = details else {
                    completion(.success(GameDetailModuleEntity()))
                    return
                }
                completion(.success(detail))
        }.eraseToAnyPublisher()
    }
    public func update(id: Int, entity: GameDetailModuleEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
                do {
                    try _realm.write {
                        _realm.add(entity, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
        }.eraseToAnyPublisher()
    }
    
    public typealias Request = Int
    
    public typealias Response = GameDetailModuleEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    
}
