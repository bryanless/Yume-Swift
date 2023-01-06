//
//  GetAnimesRepository.swift
//  
//
//  Created by Bryan on 06/01/23.
//

import Combine
import Core

public struct GetAnimesRepository<
  AnimeLocaleDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper>: Repository
where AnimeLocaleDataSource.Request == Any,
      AnimeLocaleDataSource.Response == AnimeModuleEntity,
      RemoteDataSource.Request == AnimeRankingModuleRequest,
      RemoteDataSource.Response == [AnimeRankingResponse],
      Transformer.Request == Any,
      Transformer.Response == [AnimeRankingResponse],
      Transformer.Entity == [AnimeModuleEntity],
      Transformer.Domain == [AnimeDomainModel] {

  public typealias Request = AnimeRankingModuleRequest
  public typealias Response = [AnimeDomainModel]

  private let _localeDataSource: AnimeLocaleDataSource
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer

  public init(
    localeDataSource: AnimeLocaleDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer) {

      _localeDataSource = localeDataSource
      _remoteDataSource = remoteDataSource
      _mapper = mapper
    }

  public func execute(request: AnimeRankingModuleRequest?) -> AnyPublisher<[AnimeDomainModel], Error> {
    return _localeDataSource.list(request: nil)
      .flatMap { result -> AnyPublisher<[AnimeDomainModel], Error> in
        if result.isEmpty {
          return _remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToEntity(request: nil, response: $0) }
            .flatMap { _localeDataSource.add(entities: $0) }
            .filter { $0 }
            .flatMap { _ in _localeDataSource.list(request: nil)
                .map { _mapper.transformEntityToDomain(entity: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return _localeDataSource.list(request: nil)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
}
