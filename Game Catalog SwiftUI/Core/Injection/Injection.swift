//
//  Injection.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 13/11/20.
//

import Foundation

final class Injection: NSObject {
  
  private func provideRepository() -> GameRepositoryProtocol {

    let remote: RemoteDataSource = RemoteDataSource.sharedInstance

    return GameRepository.sharedInstance(remote)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }


}
