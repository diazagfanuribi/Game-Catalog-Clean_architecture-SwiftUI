//
//  RemoteDataSource.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol: class {
    func getDeveloper() -> Observable<[DeveloperResponse]>
    func getGames() -> Observable<[GameResponse]>
//    func getTopGames() -> Observable<[GameResponse]>
}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol{
    
    func getDeveloper() -> Observable<[DeveloperResponse]> {
        return Observable<[DeveloperResponse]>.create{observer in
            if let url = URL(string: Endpoints.Gets.developer.url){
                AF.request(url)
                    .validate()
                    .responseDecodable(of: DevelopersResponse.self){ response in
                        switch response.result{
                        case .success(let value):
                            observer.onNext(value.results)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    func getGames() -> Observable<[GameResponse]> {
        return Observable<[GameResponse]>.create{observer in
            if let url = URL(string: Endpoints.Gets.games.url){
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self){ response in
                        switch response.result{
                        case .success(let value):
                            observer.onNext(value.results)
                            observer.onCompleted()
                        case .failure(let error):
                            observer.onError(error)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    func getGame() -> Observable<[GameResponse]> {
        let parameters: [String: String] = ["key": "f942ea3f14aa47d1907cc9b86fa1caae"]
        return Observable<[GameResponse]>.create{observer in
            if let url = URL(string: Endpoints.Gets.games.url){
                AF.request(url,parameters: parameters)
                    .validate()
                    .responseDecodable(of: GamesResponse.self){ response in
                        switch response.result{
                        case .success(let value):
                            observer.onNext(value.results)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }

    
    
}
