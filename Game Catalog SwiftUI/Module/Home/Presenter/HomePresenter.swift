//
//  HomePresenter.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//
import SwiftUI
import Foundation
import RxSwift

class HomePresenter: ObservableObject {

    private let disposeBag = DisposeBag()
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase



    @Published var developer: [DeveloperModel] = []
    @Published var game : [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingStateDeveloperRow: Bool = false
    @Published var loadingStateGameColumn : Bool = false
    let mainSceduler = MainScheduler.instance
    init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
    }

    func getCategories() {
    loadingStateDeveloperRow = true
    homeUseCase.getDeveloper()
      .observeOn(mainSceduler)
      .subscribe { result in
        self.developer = result
      } onError: { error in
        self.errorMessage = error.localizedDescription
      } onCompleted: {
        self.loadingStateDeveloperRow = false
      }.disposed(by: disposeBag)
    }

    func getGames() {
      loadingStateGameColumn = true
      homeUseCase.getGames()
        .observeOn(mainSceduler)
        .subscribe { result in
          self.game = result
        } onError: { error in
            self.loadingStateGameColumn = false
          self.errorMessage = error.localizedDescription
        } onCompleted: {
          self.loadingStateGameColumn = false
        }.disposed(by: disposeBag)
    }
  
  func linkBuilder<Content: View>(
    for game: GameModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
    destination: router.makeDetailView(for: game)) { content() }
  }

}
