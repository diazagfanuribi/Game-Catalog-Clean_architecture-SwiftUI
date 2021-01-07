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

public struct GetDeveloperRemoteDataSource : DataSource {
    public func execute(request: String?) -> AnyPublisher<[DeveloperResponse], Error> {
        return Future<[DeveloperResponse], Error> { completion in
            if let url = URL(string: _endpoint) {
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
    
    public typealias Request = String
    
    public typealias Response = [DeveloperResponse]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
}
