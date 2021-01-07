//
//  File.swift
//  
//
//  Created by DiazAgfa on 05/01/21.
//

import Core
import Combine

public struct UpdateFavoriteRepository<
    FavoriteLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    FavoriteLocaleDataSource.Request == String,
    FavoriteLocaleDataSource.Response == GameDetailModuleEntity,
    Transformer.Request == String,
    Transformer.Response == GameDetailResponse,
    Transformer.Entity == GameDetailModuleEntity,
    Transformer.Domain == GameDetailModel {
    
    public typealias Request = String
    public typealias Response = GameDetailModel
    
    private let _localeDataSource: FavoriteLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: FavoriteLocaleDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<GameDetailModel, Error> {
        guard let request = Int(request ?? "") else { fatalError("Request cannot be empty") }
 
        return _localeDataSource.get(id: request)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}
