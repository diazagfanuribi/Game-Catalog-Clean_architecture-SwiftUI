//
//  File.swift
//  
//
//  Created by DiazAgfa on 05/01/21.
//

import Foundation
import Core
import Combine

public struct GetDeveloperRepository<
    MealLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    MealLocaleDataSource.Request == String,
    MealLocaleDataSource.Response == DeveloperModuleEntity,
    RemoteDataSource.Request == String,
    RemoteDataSource.Response == [DeveloperResponse],
    Transformer.Request == String,
    Transformer.Response == [DeveloperResponse],
    Transformer.Entity == [DeveloperModuleEntity],
    Transformer.Domain == [DeveloperModel] {
    
    public typealias Request = String
    public typealias Response = [DeveloperModel]
    
    private let _localeDataSource: MealLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: MealLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<[DeveloperModel], Error> {
        return _localeDataSource.list(request: request)
          .flatMap { result -> AnyPublisher<[DeveloperModel], Error> in
            if result.isEmpty {
                return _remoteDataSource.execute(request: request)
                    .map { _mapper.transformResponseToEntity(request: request, response: $0) }
                    .catch { _ in _localeDataSource.list(request: request) }
                    .flatMap {  _localeDataSource.add(entities: $0) }
                .filter { $0 }
                    .flatMap { _ in _localeDataSource.list(request: request)
                        .map {  _mapper.transformEntityToDomain(entity: $0) }
                }.eraseToAnyPublisher()
            } else {
                return _localeDataSource.list(request: request)
                    .map { _mapper.transformEntityToDomain(entity: $0) }
                .eraseToAnyPublisher()
            }
          }.eraseToAnyPublisher()
    }
}
