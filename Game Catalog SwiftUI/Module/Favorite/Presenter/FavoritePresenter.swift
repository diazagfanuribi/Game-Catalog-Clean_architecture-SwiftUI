//
//  FavoritePresenter.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 09/12/20.
//

import Foundation
import Combine
import SwiftUI

class FavoritePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let router = FavoriteRouter()
    private let favUseCase: FavoriteUseCase
    @Published var game: [GameDetailModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    init(favUseCase: FavoriteUseCase) {
        self.favUseCase = favUseCase
    }
    func getGames() {
      loadingState = true
      favUseCase.getFavorite()
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                self.errorMessage = String(describing: completion)
            case .finished:
                self.loadingState = false
            }
        }, receiveValue: { game in
            self.game = game
        })
        .store(in: &cancellables)
    }
    func linkBuilder<Content: View>(
      for game: GameDetailModel,
      @ViewBuilder content: () -> Content
    ) -> some View {
      NavigationLink(
      destination: router.makeDetailView(for: game)) { content() }
    }
}
