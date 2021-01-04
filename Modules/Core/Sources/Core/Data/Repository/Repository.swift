//
//  Repository.swift
//  
//
//  Created by DiazAgfa on 04/01/21.
//

import Combine
 
public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
