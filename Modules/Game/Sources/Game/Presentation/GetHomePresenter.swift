//
//  File.swift
//  
//
//  Created by DiazAgfa on 05/01/21.
//


import Foundation
import Combine
import Core

public class GetHomePresenter<DeveloperUseCase: UseCase, GameUseCase: UseCase>: ObservableObject
where
    DeveloperUseCase.Request == String, DeveloperUseCase.Response == [DeveloperModel],
    GameUseCase.Request == String, GameUseCase.Response == [GameModel]
{
    private var cancellables: Set<AnyCancellable> = []
    
    private let _developerUseCase: DeveloperUseCase
    private let _gameUseCase: GameUseCase
    
    @Published public var developer: [DeveloperModel] = []
    @Published public var game: [GameModel] = []
    @Published public var errorMessage: String = ""
    @Published public var loadingStateDeveloperRow: Bool = false
    @Published public var loadingStateGameColumn: Bool = false
    @Published public var isError: Bool = false
    
    public init(gameUseCase: GameUseCase, developerUseCase: DeveloperUseCase) {
        _developerUseCase = developerUseCase
        _gameUseCase = gameUseCase
    }
    
    public func getGame(request: GameUseCase.Request) {
        loadingStateGameColumn = true
        _gameUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.loadingStateGameColumn = false
                case .finished:
                    self.loadingStateGameColumn = false
                }
            }, receiveValue: { item in
                self.game = item
            })
            .store(in: &cancellables)
    }
    
    public func getDeveloper(request: GameUseCase.Request) {
        loadingStateDeveloperRow = true
        _developerUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.loadingStateDeveloperRow = false
                case .finished:
                    self.loadingStateDeveloperRow = false
                }
            }, receiveValue: { item in
                self.developer = item
            })
            .store(in: &cancellables)
    }
}
