////
////  DeveloperInteractor.swift
////  Game Catalog SwiftUI
////
////  Created by DiazAgfa on 10/12/20.
////
//
//import Foundation
//import Combine
//import Game
//
//protocol DeveloperUseCase {
//    func getGameByDeveloper() -> AnyPublisher<[GameModel], Error>
//}
//class DeveloperInteractor: DeveloperUseCase {
//    private let repository: GameRepositoryProtocol
//    private let developer: DeveloperModel
//
//    required init(repository: GameRepositoryProtocol, developer: DeveloperModel) {
//      self.repository = repository
//        self.developer = developer
//    }
//    func getGameByDeveloper() -> AnyPublisher<[GameModel], Error> {
//        return repository.getGamesByDeveloper(input: developer.id)
//    }
//}
