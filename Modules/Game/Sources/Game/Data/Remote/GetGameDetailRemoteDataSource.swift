//
//  File.swift
//  
//
//  Created by DiazAgfa on 05/01/21.
//

import Foundation
import Combine
import Alamofire
import Core

public struct GetGameDetailRemoteDataSource : DataSource {
    public func execute(request: String?) -> AnyPublisher<GameDetailResponse, Error> {
        return Future<GameDetailResponse, Error> { completion in
            guard let request = request else { return completion(.failure(URLError.invalidResponse)) }
            let urlDetail = _endpoint + request
            if let url = URL(string: urlDetail) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GameDetailResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            print(value)
                            completion(.success(value))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    public typealias Request = String
    
    public typealias Response = GameDetailResponse
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
}
