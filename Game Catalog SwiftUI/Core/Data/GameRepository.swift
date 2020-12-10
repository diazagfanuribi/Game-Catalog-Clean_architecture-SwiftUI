//
//  GameRepository.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import Foundation
import RxSwift
import Combine
import os

protocol GameRepositoryProtocol {
    func getDeveloper() -> AnyPublisher<[DeveloperModel], Error>
    func getGames()-> AnyPublisher<[GameModel], Error>
    func getGameDetail(game: GameDetailModel) -> AnyPublisher<GameDetailModel, Error>
    func getFavorite() -> AnyPublisher<[GameDetailModel], Error>
    func updateFavorite(from game: GameDetailEntity) -> AnyPublisher<GameDetailModel, Error>
    func getGamesByDeveloper(input developer: Int) -> AnyPublisher<[GameModel], Error>
}

final class GameRepository: NSObject {
    let logger = Logger()
    typealias GameInstance = (RemoteDataSource, LocaleDataSource) -> GameRepository

    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource

    private init( remote: RemoteDataSource, locale: LocaleDataSource) {
      self.remote = remote
      self.locale = locale
    }

    static let sharedInstance: GameInstance = { remoteRepo, localeRepo in
      return GameRepository(remote: remoteRepo, locale: localeRepo)
    }
}

extension GameRepository: GameRepositoryProtocol {
    func getGamesByDeveloper(input developer: Int) -> AnyPublisher<[GameModel], Error> {
        return self.remote.getGamesByDeveloper(input: developer)
            .map {Mapper.mapGameResponsesToDomains(input: $0)}
            .eraseToAnyPublisher()
    }
    func getFavorite() -> AnyPublisher<[GameDetailModel], Error> {
        return self.locale.getFavorite()
            .map { result in return result.map {Mapper.mapGameDetailEntityToDomain(input: $0)}}
            .eraseToAnyPublisher()
    }
    func updateFavorite(from game: GameDetailEntity) -> AnyPublisher<GameDetailModel, Error> {
        return self.locale.updateFavorite(by: game)
            .map { Mapper.mapGameDetailEntityToDomain(input: $0)}
            .eraseToAnyPublisher()
    }
    func getGames() -> AnyPublisher<[GameModel], Error> {
        return self.locale.getGames()
            .flatMap { result -> AnyPublisher<[GameModel], Error> in
                if result.isEmpty {
                    return self.remote.getGames()
                        .map {
                            Mapper.mapGameResponsesToDomains(input: $0)
                        }
                        .map {Mapper.mapGameDomaintoEntity(input: $0)}
                        .catch {_ in self.locale.getGames()
                        }
                        .flatMap {
                            self.locale.addGame(from: $0)
                        }
                        .filter {$0}
                        .flatMap { _ in self.locale.getGames()
                                .map {Mapper.mapGameEntityToDomain(input: $0)}
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getGames()
                        .map { Mapper.mapGameEntityToDomain(input: $0) }
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()

    }

    func getDeveloper() -> AnyPublisher<[DeveloperModel], Error> {
        return self.locale.getDeveloper()
            .flatMap {result -> AnyPublisher<[DeveloperModel], Error> in
                if result.isEmpty {
                    return self.remote.getDeveloper()
                        .map {
                            Mapper.mapDeveloperResponsesToDomains(input: $0)
                        }
                        .map {Mapper.mapDeveloperDomaintoEntity(input: $0)}
                        .catch {_ in self.locale.getDeveloper()
                        }
                        .flatMap {
                            self.locale.addDeveloper(from: $0)
                        }
                        .filter {$0}
                        .flatMap { _ in self.locale.getDeveloper()
                                .map {Mapper.mapDeveloperEntityToDomain(input: $0)}
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getDeveloper()
                        .map {Mapper.mapDeveloperEntityToDomain(input: $0)}
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    func getGameDetail(game: GameDetailModel) -> AnyPublisher<GameDetailModel, Error> {
        let ids = game.id
        let res = self.locale.getGameDetail(by: ids)
            .flatMap {result -> AnyPublisher<GameDetailModel, Error> in
                if result.desc == "" && result.ids == 0 {
                    return self.remote.getGameDetail(input: game)
                        .map {
                            Mapper.mapGameDetailResponseToDomain(input: $0)
                        }
                        .map {Mapper.mapGameDetailDomainToEntity(input: $0)}
//                        .catch {
//                            _ in self.locale.getGameDetail(by: ids)
//                        }
                        .flatMap {
                            self.locale.addGameDetail(from: $0)
                        }
                        .filter {$0}
                        .flatMap { _ in self.locale.getGameDetail(by: ids)
                                .map {Mapper.mapGameDetailEntityToDomain(input: $0)}
                            .eraseToAnyPublisher()
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getGameDetail(by: ids)
                        .map {Mapper.mapGameDetailEntityToDomain(input: $0)}
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
        return res
    }

}
