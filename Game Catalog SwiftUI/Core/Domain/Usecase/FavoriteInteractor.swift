//
//  FavoriteInteractor.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 09/12/20.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    func getFavorite() -> AnyPublisher<[GameDetailModel], Error>
}
class FavoriteInteractor: FavoriteUseCase {
    private let repository: GameRepositoryProtocol

    required init(repository: GameRepositoryProtocol) {
      self.repository = repository
    }
    func getFavorite() -> AnyPublisher<[GameDetailModel], Error> {
        return repository.getFavorite()
    }
}
