//
//  LocalDataSource.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 06/12/20.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: class {
    func getGames() -> AnyPublisher<[GameEntity], Error>
    func getDeveloper() -> AnyPublisher<[DeveloperEntity], Error>
    func getGameDetail(by ids: Int) -> AnyPublisher<GameDetailEntity, Error>
    func updateFavorite(by game: GameDetailEntity) -> AnyPublisher<GameDetailEntity, Error>
    func addGame(from games: [GameEntity]) -> AnyPublisher<Bool, Error>
    func addDeveloper(from developers: [DeveloperEntity])-> AnyPublisher<Bool, Error>
    func addGameDetail(from detail: GameDetailEntity)-> AnyPublisher<Bool, Error>
    func getFavorite()-> AnyPublisher<[GameDetailEntity], Error>
}

final class LocaleDataSource: NSObject {

  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }
}
extension LocaleDataSource: LocaleDataSourceProtocol {
    func addGame(from games: [GameEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for game in games {
                            realm.add(game, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    func addDeveloper(from developers: [DeveloperEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for developer in developers {
                            realm.add(developer, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    func addGameDetail(from detail: GameDetailEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(detail, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    func getGames() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let game: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(game.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    func getFavorite() -> AnyPublisher<[GameDetailEntity], Error> {
        return Future<[GameDetailEntity], Error> { completion in
            if let realm = self.realm {
                let game = {
                    realm.objects(GameDetailEntity.self)
                        .filter("favorite = \(true)")
                }()
                completion(.success(game.toArray(ofType: GameDetailEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    func getDeveloper() -> AnyPublisher<[DeveloperEntity], Error> {
        return Future<[DeveloperEntity], Error> { completion in
            if let realm = self.realm {
                let developer: Results<DeveloperEntity> = {
                    realm.objects(DeveloperEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(developer.toArray(ofType: DeveloperEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    func getGameDetail(by ids: Int) -> AnyPublisher<GameDetailEntity, Error> {
        return Future<GameDetailEntity, Error> { completion in
            if let realm = self.realm {
                let details: GameDetailEntity? = {
                    realm.object(ofType: GameDetailEntity.self, forPrimaryKey: ids)
                }()
                guard let detail = details else {
                    completion(.success(GameDetailEntity()))
                    return
                }
                completion(.success(detail))

            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    func updateFavorite(by game: GameDetailEntity) -> AnyPublisher<GameDetailEntity, Error> {
        return Future<GameDetailEntity, Error> { completion in
            if let realm = self.realm, let detailEntity={
                realm.objects(GameDetailEntity.self).filter("ids = \(game.ids)")
            }().first {
                do {
                    try realm.write {
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
}

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
