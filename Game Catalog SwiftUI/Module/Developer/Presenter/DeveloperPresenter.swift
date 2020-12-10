//
//  DeveloperPresenter.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/12/20.
//

import SwiftUI
import Foundation
import Combine

class DeveloperPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let router = DeveloperRouter()
    private let developerUseCase: DeveloperUseCase

    @Published var game: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    init(developerUseCase: DeveloperUseCase) {
    self.developerUseCase = developerUseCase
    }

    func getGamesByDeveloper() {
      loadingState = true
      developerUseCase.getGameByDeveloper()
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
    for game: GameModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
    destination: router.makeDetailView(for: game)) { content() }
  }

}
