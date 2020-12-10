//
//  HomePresenter.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//
import SwiftUI
import Foundation
import Combine

class HomePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase

    @Published var developer: [DeveloperModel] = []
    @Published var game: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingStateDeveloperRow: Bool = false
    @Published var loadingStateGameColumn: Bool = false
    init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
    }

    func getCategories() {
    loadingStateDeveloperRow = true
    homeUseCase.getDeveloper()
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                self.errorMessage = String(describing: completion)
            case .finished :
                self.loadingStateDeveloperRow = false
            }
        }, receiveValue: { developer in
            self.developer = developer
        })
        .store(in: &cancellables)
    }

    func getGames() {
      loadingStateGameColumn = true
      homeUseCase.getGames()
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                self.errorMessage = String(describing: completion)
            case .finished:
                self.loadingStateGameColumn = false
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

    func linkDeveloperBuilder<Content: View>(
      for developer: DeveloperModel,
      @ViewBuilder content: () -> Content
    ) -> some View {
      NavigationLink(
        destination: router.makeDeveloperListView(input: developer.name)) { content() }
    }
}
