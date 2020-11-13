//
//  GameRepository.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import Foundation
import RxSwift

protocol GameRepositoryProtocol {
    func getDeveloper() -> Observable<[DeveloperModel]>
    
    func getGames()-> Observable<[GameModel]>
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

extension GameRepository : GameRepositoryProtocol {
    func getGames() -> Observable<[GameModel]> {
        return self.remote.getGames()
            .map{
                Mapper.mapGameResponsesToDomains(input: $0)
            }
            .filter{ !$0.isEmpty}
    }
    
    func getDeveloper() -> Observable<[DeveloperModel]> {
        return self.remote.getDeveloper()
            .map{Mapper.mapDeveloperResponsesToDomains(input: $0)}
            .filter { !$0.isEmpty }
    }
    
    
}
