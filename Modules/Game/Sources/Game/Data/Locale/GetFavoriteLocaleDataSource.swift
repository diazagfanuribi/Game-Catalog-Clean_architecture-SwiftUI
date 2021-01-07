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

public struct GetFavoriteLocaleDataSource : LocaleDataSource {
    public func list(request: String?) -> AnyPublisher<[GameDetailModuleEntity], Error> {
        return Future<[GameDetailModuleEntity], Error> { completion in
                let game = {
                    _realm.objects(GameDetailModuleEntity.self)
                        .filter("favorite = \(true)")
                }()
                completion(.success(game.toArray(ofType: GameDetailModuleEntity.self)))
        }.eraseToAnyPublisher()    }
    
    public func add(entities: [GameDetailModuleEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: Int) -> AnyPublisher<GameDetailModuleEntity, Error> {
        return Future<GameDetailModuleEntity, Error> { completion in
            if let detailEntity={
                _realm.objects(GameDetailModuleEntity.self).filter("ids = \(id)")
            }().first {
                do {
                    try _realm.write {
                        detailEntity.setValue(!detailEntity.favorite, forKey: "favorite")
                    }
                    completion(.success(detailEntity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))

            }
        }.eraseToAnyPublisher()
        
    }
    
    public func update(id: Int, entity: GameDetailModuleEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public typealias Request = String
    
    public typealias Response = GameDetailModuleEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
}
