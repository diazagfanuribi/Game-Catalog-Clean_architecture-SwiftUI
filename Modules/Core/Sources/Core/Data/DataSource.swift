//
//  File.swift
//  
//
//  Created by DiazAgfa on 04/01/21.
//

import Combine
 
public protocol DataSource {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
