//
//  File.swift
//  
//
//  Created by DiazAgfa on 05/01/21.
//

import Foundation
import Core
import Combine
import RealmSwift

public struct GetDeveloperLocaleDataSource: LocaleDataSource{
    public func list(request: String?) -> AnyPublisher<[DeveloperModuleEntity], Error> {
        return Future<[DeveloperModuleEntity], Error> { completion in
                let developer: Results<DeveloperModuleEntity> = {
                    _realm.objects(DeveloperModuleEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(developer.toArray(ofType: DeveloperModuleEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [DeveloperModuleEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
                do {
                    try _realm.write {
                        for developer in entities {
                            _realm.add(developer, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
        }.eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<DeveloperModuleEntity, Error> {
        fatalError()
    }
    
    public func update(id: Int, entity: DeveloperModuleEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public typealias Request = String
    
    public typealias Response = DeveloperModuleEntity
    
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
}
