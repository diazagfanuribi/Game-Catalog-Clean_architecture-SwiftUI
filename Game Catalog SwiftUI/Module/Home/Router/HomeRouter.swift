//
//  HomeRouter.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 18/11/20.
//

import Foundation
import SwiftUI

class HomeRouter {

  func makeDetailView(for game: GameModel) -> some View {
    let detail = Mapper.mapGameDomainToGameDetailDomain(input: game)
    let detailUseCase = Injection.init().provideDetail(game: detail)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }

    func makeDeveloperListView(input developer: DeveloperModel) -> some View {
        let developerUseCase = Injection.init().provideDeveloper(developer: developer)
        let presenter = DeveloperPresenter(developerUseCase: developerUseCase)
        return DeveloperView(title: developer.name, presenter: presenter)
    }
}
