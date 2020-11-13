//
//  HomeInteractor.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import Foundation
import RxSwift

protocol HomeUseCase {

  func getDeveloper() -> Observable<[DeveloperModel]>
  func getGames() -> Observable<[GameModel]>
}

class HomeInteractor: HomeUseCase {

  private let repository: GameRepositoryProtocol
  
  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  func getDeveloper() -> Observable<[DeveloperModel]> {
    return repository.getDeveloper()
    }
    
    func getGames() -> Observable<[GameModel]> {
        return repository.getGames()
    }


}
