//
//  File.swift
//  
//
//  Created by DiazAgfa on 05/01/21.
//

import Foundation
import Combine
import Core

public struct GetFavoriteRepository<
    GameLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    GameLocaleDataSource.Request == String,
    GameLocaleDataSource.Response == GameDetailModuleEntity,
    Transformer.Request == String,
    Transformer.Response == [GameDetailModel],
    Transformer.Entity == [GameDetailModuleEntity],
    Transformer.Domain == [GameDetailModel]{
    
    public typealias Request = String
    public typealias Response = [GameDetailModel]
    
    private let _localeDataSource: GameLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: GameLocaleDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<[GameDetailModel], Error> {
        return _localeDataSource.list(request: request)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}
