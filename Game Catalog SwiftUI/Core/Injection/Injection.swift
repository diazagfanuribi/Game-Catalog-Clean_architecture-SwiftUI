//
//  Injection.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 13/11/20.
//
import UIKit
import Foundation
import RealmSwift
import Core
import Game

// swiftlint:disable force_cast

final class Injection: NSObject {
    
    func provideFavorites<U: UseCase>() -> U where U.Request == String, U.Response == [GameDetailModel] {
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate

        let locale = GetFavoriteLocaleDataSource(realm: appDelegate.realm)
        
        let mapper = FavoriteTransformer()
        
        let repository = GetFavoriteRepository(localeDataSource: locale, mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideGame<U: UseCase>() -> U where U.Request == String, U.Response == [GameModel] {
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate

        let locale = GetGamesLocaleDataSource(realm: appDelegate.realm)
        
        let remote = GetGamesRemoteDataSource(endpoint: Endpoints.Gets.games.url)
        
        let mapper = GamesTransformer()
        
        let repository = GetGameRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideDeveloper<U: UseCase>() -> U where U.Request == String, U.Response == [DeveloperModel] {
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate

        let locale = GetDeveloperLocaleDataSource(realm: appDelegate.realm)
        
        let remote = GetDeveloperRemoteDataSource(endpoint: Endpoints.Gets.developer.url)
        
        let mapper = DeveloperTransformer()
        
        let repository = GetDeveloperRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideGameDetail<U: UseCase>() -> U where U.Request == String, U.Response == GameDetailModel {
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate

        let locale = GetGameDetailLocaleDataSource(realm: appDelegate.realm)
        let remote = GetGameDetailRemoteDataSource(endpoint: Endpoints.Gets.detail.url)
        let mapper = GameDetailTransformer()
        let repository = GetGameDetailRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideGameByDeveloper<U: UseCase>() -> U where U.Request == String, U.Response == [GameModel] {        
        let remote = GetGameByDeveloperRemoteDataSource(endpoint: Endpoints.Gets.games.url)
        let mapper = GamesTransformer()
        let repository = GetGamesByDeveloperRepository(remoteDataSource: remote, mapper: mapper)
        return Interactor(repository: repository) as! U
    }
    
    func provideUpdateFavorite<U: UseCase>() -> U where U.Request == String, U.Response == GameDetailModel {
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate

        let locale = GetFavoriteLocaleDataSource(realm: appDelegate.realm)
        let mapper = GameDetailTransformer()
        
        let repository = UpdateFavoriteRepository(localeDataSource: locale, mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    
    
    
//  private func provideRepository() -> GameRepositoryProtocol {
//    let realm = try? Realm()
//
//    let remote: RemoteDataSource = RemoteDataSource.sharedInstance
//    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
//
//    return GameRepository.sharedInstance(remote, locale)
//  }
//
//  func provideHome() -> HomeUseCase {
//    let repository = provideRepository()
//    return HomeInteractor(repository: repository)
//  }
//
//    func provideDetail(game: GameDetailModel) -> DetailUseCase {
//      let repository = provideRepository()
//      return DetailInteractor(repository: repository, game: game)
//    }
//
//    func provideFavorite() -> FavoriteUseCase {
//      let repository = provideRepository()
//      return FavoriteInteractor(repository: repository)
//    }
//    func provideDeveloper(developer: DeveloperModel) -> DeveloperUseCase {
//        let repository = provideRepository()
//        return DeveloperInteractor(repository: repository, developer: developer)
//    }
}
