//
//  HomeInteractor.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import Foundation
import Combine

protocol HomeUseCase {
  func getDeveloper() -> AnyPublisher<[DeveloperModel], Error>
  func getGames() -> AnyPublisher<[GameModel], Error>
}

class HomeInteractor: HomeUseCase {
  private let repository: GameRepositoryProtocol

  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }

  func getDeveloper() -> AnyPublisher<[DeveloperModel], Error> {
    return repository.getDeveloper()
    }

    func getGames() -> AnyPublisher<[GameModel], Error> {
        return repository.getGames()
    }

}
