//
//  Injection.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 13/11/20.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
  private func provideRepository() -> GameRepositoryProtocol {
    let realm = try? Realm()

    let remote: RemoteDataSource = RemoteDataSource.sharedInstance
    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)

    return GameRepository.sharedInstance(remote, locale)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }

    func provideDetail(game: GameDetailModel) -> DetailUseCase {
      let repository = provideRepository()
      return DetailInteractor(repository: repository, game: game)
    }

    func provideFavorite() -> FavoriteUseCase {
      let repository = provideRepository()
      return FavoriteInteractor(repository: repository)
    }
    func provideDeveloper(developer: DeveloperModel) -> DeveloperUseCase {
        let repository = provideRepository()
        return DeveloperInteractor(repository: repository, developer: developer)
    }
}
