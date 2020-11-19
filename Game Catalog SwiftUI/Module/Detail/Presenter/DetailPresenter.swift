//
//  DetailPresenter.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 18/11/20.
//


import SwiftUI
import RxSwift

class DetailPresenter: ObservableObject {

  private let detailUseCase: DetailUseCase
  private let disposeBag = DisposeBag()


  @Published var gameDetail: GameDetailModel?
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
    
  let mainSceduler = MainScheduler.instance
    
  @Published var loadingStateDetail: Bool = false



  init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
  }
    
    func getDetail(){
        self.loadingStateDetail=true
        self.detailUseCase.getGameDetail()
            .observeOn(mainSceduler)
            .subscribe{result in
                self.gameDetail = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
              } onCompleted: {
                self.loadingStateDetail = false
              }.disposed(by: disposeBag)
    }

}
