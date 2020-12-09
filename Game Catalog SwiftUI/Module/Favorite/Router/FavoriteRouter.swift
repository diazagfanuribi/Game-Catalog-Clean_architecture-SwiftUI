//
//  FavoriteRouter.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 09/12/20.
//

import Foundation
import SwiftUI

class FavoriteRouter {
    func makeDetailView(for game: GameDetailModel) -> some View {
      let detailUseCase = Injection.init().provideDetail(game: game)
      let presenter = DetailPresenter(detailUseCase: detailUseCase)
      return DetailView(presenter: presenter)
    }

      func makeDeveloperListView(input title: String) -> some View {
          return DeveloperView(title: title)
      }
}
