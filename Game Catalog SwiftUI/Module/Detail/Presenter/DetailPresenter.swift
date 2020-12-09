//
//  DetailPresenter.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 18/11/20.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {

  private var cancellables: Set<AnyCancellable> = []

  private let detailUseCase: DetailUseCase

  @Published var gameDetail: GameDetailModel
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  @Published var loadingStateDetail: Bool = false

  init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
    gameDetail = detailUseCase.getGameDetail()
  }

    func getDetail() {
        self.loadingStateDetail=true
        self.detailUseCase.getGameDetailRemote()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingStateDetail = false
                }
            }, receiveValue: { result in
                self.gameDetail = result
            }).store(in: &cancellables)
    }

    func updateFavoriteMeal() {
        self.loadingStateDetail = true
        detailUseCase.updateFavorite(from: gameDetail)
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
              self.errorMessage = String(describing: completion)
            case .finished:
              self.loadingStateDetail = false
            }
          }, receiveValue: { detail in
            self.gameDetail = detail
          })
          .store(in: &cancellables)
    }
}
