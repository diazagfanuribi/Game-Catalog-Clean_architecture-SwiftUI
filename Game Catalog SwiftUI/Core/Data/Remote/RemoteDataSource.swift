//
//  RemoteDataSource.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import Foundation
import Alamofire
import RxSwift
import Combine

protocol RemoteDataSourceProtocol: class {
    func getDeveloper() -> AnyPublisher<[DeveloperResponse],Error>
    func getGames() -> AnyPublisher<[GameResponse],Error>
    func getGameDetail(input game: GameModel) -> AnyPublisher<GameDetailResponse,Error>
}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol{
    func getDeveloper() -> AnyPublisher<[DeveloperResponse], Error> {
        return Future<[DeveloperResponse],Error>{ completion in
            if let url = URL(string: Endpoints.Gets.developer.url){
                AF.request(url)
                    .validate()
                    .responseDecodable(of: DevelopersResponse.self){ response in
                        switch response.result{
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
        return Future<[GameResponse],Error>{completion in
            if let url = URL(string: Endpoints.Gets.games.url){
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self){ response in
                        switch response.result{
                        case .success(let value):
                            completion(.success(value.results))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getGameDetail(input game: GameModel) -> AnyPublisher<GameDetailResponse, Error> {
        return Future<GameDetailResponse,Error>{ completion in
            let url_detail = Endpoints.Gets.detail.url + "\(game.id)"
            if let url = URL(string: url_detail){
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GameDetailResponse.self){ response in
                        switch response.result{
                        case .success(let value):
                            completion(.success(value))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    
//    func getDeveloper() -> Observable<[DeveloperResponse]> {
//        return Observable<[DeveloperResponse]>.create{observer in
//            if let url = URL(string: Endpoints.Gets.developer.url){
//                AF.request(url)
//                    .validate()
//                    .responseDecodable(of: DevelopersResponse.self){ response in
//                        switch response.result{
//                        case .success(let value):
//                            observer.onNext(value.results)
//                            observer.onCompleted()
//                        case .failure:
//                            observer.onError(URLError.invalidResponse)
//                        }
//                    }
//            }
//            return Disposables.create()
//        }
//    }
//
//    func getGames() -> Observable<[GameResponse]> {
//        return Observable<[GameResponse]>.create{observer in
//            if let url = URL(string: Endpoints.Gets.games.url){
//                AF.request(url)
//                    .validate()
//                    .responseDecodable(of: GamesResponse.self){ response in
//                        switch response.result{
//                        case .success(let value):
//                            observer.onNext(value.results)
//                            observer.onCompleted()
//                        case .failure(let error):
//                            observer.onError(error)
//                        }
//                    }
//            }
//            return Disposables.create()
//        }
//    }
//
//    func getGameDetail(input game : GameModel) -> Observable<GameDetailResponse> {
//        return Observable<GameDetailResponse>.create{observer in
//            let url_detail = Endpoints.Gets.detail.url + "\(game.id)"
//            if let url = URL(string: url_detail){
//                AF.request(url)
//                    .validate()
//                    .responseDecodable(of: GameDetailResponse.self){ response in
//                        switch response.result{
//                        case .success(let value):
//                            observer.onNext(value)
//                            observer.onCompleted()
//                        case .failure(let error):
//                            observer.onError(error)
//                        }
//                    }
//            }
//            return Disposables.create()
//        }
//    }
//
    
}
