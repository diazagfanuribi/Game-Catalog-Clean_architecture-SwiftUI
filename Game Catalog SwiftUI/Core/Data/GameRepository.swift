//
//  GameRepository.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import Foundation
import RxSwift
import Combine

protocol GameRepositoryProtocol {
    func getDeveloper() -> AnyPublisher<[DeveloperModel], Error>

    func getGames()-> AnyPublisher<[GameModel], Error>

    func getGameDetail(game: GameModel) -> AnyPublisher<GameDetailModel, Error>
}

final class GameRepository: NSObject {
    typealias GameInstance = (RemoteDataSource) -> GameRepository

    fileprivate let remote: RemoteDataSource

    private init( remote: RemoteDataSource) {
      self.remote = remote
    }

    static let sharedInstance: GameInstance = { remoteRepo in
      return GameRepository(remote: remoteRepo)
    }
}

extension GameRepository: GameRepositoryProtocol {

    func getGames() -> AnyPublisher<[GameModel], Error> {
        return self.remote.getGames()
            .map {
                Mapper.mapGameResponsesToDomains(input: $0)
            }
            .filter { !$0.isEmpty}
            .eraseToAnyPublisher()
    }

    func getDeveloper() -> AnyPublisher<[DeveloperModel], Error> {
        return self.remote.getDeveloper()
            .map {Mapper.mapDeveloperResponsesToDomains(input: $0)}
            .filter { !$0.isEmpty }
            .eraseToAnyPublisher()
    }

    func getGameDetail(game: GameModel) -> AnyPublisher<GameDetailModel, Error> {
        return self.remote.getGameDetail(input: game)
            .map {Mapper.mapGameDetailResponseToDomain(input: $0)}
            .eraseToAnyPublisher()
    }

}
