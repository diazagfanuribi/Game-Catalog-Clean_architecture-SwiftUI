//
//  RemoteDataSource.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: class {
    func getDeveloper() -> AnyPublisher<[DeveloperResponse], Error>
    func getGames() -> AnyPublisher<[GameResponse], Error>
    func getGameDetail(input game: GameDetailModel) -> AnyPublisher<GameDetailResponse, Error>
}

final class RemoteDataSource: NSObject {
  private override init() { }
  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getDeveloper() -> AnyPublisher<[DeveloperResponse], Error> {
        return Future<[DeveloperResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.developer.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: DevelopersResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }

    func getGames() -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> {completion in
            if let url = URL(string: Endpoints.Gets.games.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }

    func getGameDetail(input game: GameDetailModel) -> AnyPublisher<GameDetailResponse, Error> {
        return Future<GameDetailResponse, Error> { completion in
            let urlDetail = Endpoints.Gets.detail.url + "\(game.id)"
            if let url = URL(string: urlDetail) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GameDetailResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }

}
