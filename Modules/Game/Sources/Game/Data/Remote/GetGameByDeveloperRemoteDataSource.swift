//
//  File.swift
//  
//
//  Created by DiazAgfa on 05/01/21.
//

import Foundation
import Core
import Combine
import Alamofire

public struct GetGameByDeveloperRemoteDataSource : DataSource {
    public func execute(request: String?) -> AnyPublisher<[GameResponse], Error> {
        
        return Future<[GameResponse], Error> {completion in
            guard let request = request else { return completion(.failure(URLError.invalidResponse)) }
            let urls = _endpoint + "&developers=" + request
            if let url = URL(string: urls) {
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
    
    public typealias Request = String
    
    public typealias Response = [GameResponse]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
}
