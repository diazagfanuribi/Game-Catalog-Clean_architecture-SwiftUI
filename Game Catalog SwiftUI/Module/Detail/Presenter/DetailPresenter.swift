//
//  DetailPresenter.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 18/11/20.
//


import SwiftUI
import RxSwift
import Combine

class DetailPresenter: ObservableObject {
    
  private var cancellables: Set<AnyCancellable> = []

  private let detailUseCase: DetailUseCase
  private let disposeBag = DisposeBag()


  @Published var gameDetail: GameDetailModel
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
    
  let mainSceduler = MainScheduler.instance
    
  @Published var loadingStateDetail: Bool = false



  init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
    gameDetail = detailUseCase.getGameDetail()
  }
    
    func getDetail(){
        self.loadingStateDetail=true
        self.detailUseCase.getGameDetailRemote()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {completion in
                switch completion{
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingStateDetail = false
                }
            }, receiveValue: { result in
                self.gameDetail = result
            }).store(in: &cancellables)
    }

}
