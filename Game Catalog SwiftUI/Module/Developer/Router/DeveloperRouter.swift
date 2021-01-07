//
//  DeveloperRouter.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/12/20.
//

import Foundation
import SwiftUI
import Game
import Core

class DeveloperRouter {
  func makeDetailView(for game: GameModel) -> some View {
    let detailUseCase : Interactor<
        String,GameDetailModel,GetGameDetailRepository<GetGameDetailLocaleDataSource,GetGameDetailRemoteDataSource,GameDetailTransformer>> = Injection.init().provideGameDetail()
    let favoriteUseCase : Interactor<String,GameDetailModel,UpdateFavoriteRepository<GetFavoriteLocaleDataSource,GameDetailTransformer>> = Injection.init().provideUpdateFavorite()
    let presenter = GetDetailPresenter(gameUseCase: detailUseCase, updateFavoriteUseCase: favoriteUseCase , gameDetail: game.id)
    return DetailView(presenter: presenter)
  }
}
