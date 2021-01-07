//
//  File.swift
//  
//
//  Created by DiazAgfa on 05/01/21.
//
import Core
import Combine

public struct GetGameDetailRepository<
    MealLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    MealLocaleDataSource.Request == Int,
    MealLocaleDataSource.Response == GameDetailModuleEntity,
    RemoteDataSource.Request == String,
    RemoteDataSource.Response == GameDetailResponse,
    Transformer.Request == String,
    Transformer.Response == GameDetailResponse,
    Transformer.Entity == GameDetailModuleEntity,
    Transformer.Domain == GameDetailModel {
    
    public typealias Request = String
    public typealias Response = GameDetailModel
    
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
    
    public func execute(request: String?) -> AnyPublisher<GameDetailModel, Error> {
        guard let request = Int(request ?? "") else { fatalError("Request cannot be empty") }
        return _localeDataSource.get(id: request)
          .flatMap { result -> AnyPublisher<GameDetailModel, Error> in
            if result.desc == "" && result.ids == 0 {
                return _remoteDataSource.execute(request: String(request))
                    .map { _mapper.transformResponseToEntity(request: String(request), response: $0) }
//                    .catch { _ in _localeDataSource.get(id: request) }
                    .flatMap {
                        _localeDataSource.update(id: $0.ids, entity: $0) }
                .filter { $0 }
                    .flatMap { _ in _localeDataSource.get(id: request)
                        .map { _mapper.transformEntityToDomain(entity: $0) }
                }.eraseToAnyPublisher()
            } else {
                return _localeDataSource.get(id: request)
                    .map { _mapper.transformEntityToDomain(entity: $0) }
                .eraseToAnyPublisher()
            }
          }.eraseToAnyPublisher()
    }
}
