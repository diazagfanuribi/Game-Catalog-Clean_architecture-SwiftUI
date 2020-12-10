//
//  DeveloperRouter.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/12/20.
//

import Foundation
import SwiftUI

class DeveloperRouter {
  func makeDetailView(for game: GameModel) -> some View {
    let detail = Mapper.mapGameDomainToGameDetailDomain(input: game)
    let detailUseCase = Injection.init().provideDetail(game: detail)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
}
