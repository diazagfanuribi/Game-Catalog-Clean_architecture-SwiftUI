//
//  DetailGameInteractor.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import Foundation
import RxSwift
import Combine

protocol DetailUseCase {
  func getGameDetailRemote() -> AnyPublisher<GameDetailModel, Error>
  func getGameDetail() -> GameDetailModel
  func updateFavorite(from game: GameDetailModel) -> AnyPublisher<GameDetailModel, Error>
}

class DetailInteractor: DetailUseCase {
  private let repository: GameRepositoryProtocol
  private let game: GameDetailModel

  required init(
    repository: GameRepositoryProtocol,
    game: GameDetailModel
  ) {
    self.repository = repository
    self.game = game
  }

  func getGameDetailRemote() -> AnyPublisher<GameDetailModel, Error> {
    return repository.getGameDetail(game: game)
  }

  func getGameDetail() -> GameDetailModel {
        return game
    }
  func updateFavorite(from game: GameDetailModel) -> AnyPublisher<GameDetailModel, Error> {
        return repository.updateFavorite(from: Mapper.mapGameDetailDomainToEntity(input: game))
    }

}
