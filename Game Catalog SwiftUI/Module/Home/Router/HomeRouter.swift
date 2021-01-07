//
//  HomeRouter.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 18/11/20.
//

import Foundation
import SwiftUI
import Game
import Core

class HomeRouter {

  func makeDetailView(for game: GameModel) -> some View {
//    let detail = Mapper.mapGameDomainToGameDetailDomain(input: game)
    
    let detailUseCase : Interactor<
        String,GameDetailModel,GetGameDetailRepository<GetGameDetailLocaleDataSource,GetGameDetailRemoteDataSource,GameDetailTransformer>> = Injection.init().provideGameDetail()
    let favoriteUseCase : Interactor<String,GameDetailModel,UpdateFavoriteRepository<GetFavoriteLocaleDataSource,GameDetailTransformer>> = Injection.init().provideUpdateFavorite()
    let presenter = GetDetailPresenter(gameUseCase: detailUseCase, updateFavoriteUseCase: favoriteUseCase , gameDetail: game.id)
    return DetailView(presenter: presenter)
  }

    func makeDeveloperListView(input developer: DeveloperModel) -> some View {
        let developerUseCase : Interactor<String,[GameModel],GetGamesByDeveloperRepository<GetGameByDeveloperRemoteDataSource,GamesTransformer>> = Injection.init().provideGameByDeveloper()
        let presenter = GetListPresenter(useCase: developerUseCase)
        return DeveloperView(developer: developer, presenter: presenter)
    }
}
