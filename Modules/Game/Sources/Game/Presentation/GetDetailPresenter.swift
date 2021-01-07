//
//  File.swift
//  
//
//  Created by DiazAgfa on 06/01/21.
//

import Foundation
import Core
import Combine

public class GetDetailPresenter<UpdateFavoriteUseCase: UseCase, GameUseCase: UseCase>: ObservableObject
where
    UpdateFavoriteUseCase.Request == String, UpdateFavoriteUseCase.Response == GameDetailModel,
    GameUseCase.Request == String, GameUseCase.Response == GameDetailModel
 {
    private var cancellables: Set<AnyCancellable> = []
    private let _updateFavoriteUseCase: UpdateFavoriteUseCase
    private let _gameUseCase: GameUseCase
    
    @Published public var game: GameDetailModel
    @Published public var errorMessage: String = ""
    @Published public var loadingStateDeveloperRow: Bool = false
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(gameUseCase: GameUseCase, updateFavoriteUseCase: UpdateFavoriteUseCase, gameDetail: Int) {
        _updateFavoriteUseCase = updateFavoriteUseCase
        _gameUseCase = gameUseCase
        game = GameDetailModel(id: gameDetail, name: "", rating: 0, released: "", background: "", description: "", backgroundAdditional: "", website: "", favorite: false)
    }
    
    public func getGame(request: GameUseCase.Request) {
        isLoading  = true
        _gameUseCase.execute(request: String(game.id))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.game = item
                print(item)
            })
            .store(in: &cancellables)
    }
    
    public func updateFavorite(request: UpdateFavoriteUseCase.Request) {
        _updateFavoriteUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.game = item
            })
            .store(in: &cancellables)
    }
    
}
