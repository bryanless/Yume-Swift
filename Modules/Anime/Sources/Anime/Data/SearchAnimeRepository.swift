//
//  SearchAnimeRepository.swift
//  
//
//  Created by Bryan on 09/01/23.
//

import Combine
import Core

public struct SearchAnimeRepository<
  AnimeLocaleDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper>: Repository
where AnimeLocaleDataSource.Request == AnimeListRequest,
      AnimeLocaleDataSource.Response == AnimeModuleEntity,
      RemoteDataSource.Request == AnimeListRequest,
      RemoteDataSource.Response == [AnimeDataResponse],
      Transformer.Request == Any,
      Transformer.Response == [AnimeDataResponse],
      Transformer.Entity == [AnimeModuleEntity],
      Transformer.Domain == [AnimeDomainModel] {

  public typealias Request = AnimeListRequest
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

  public func execute(request: AnimeListRequest?) -> AnyPublisher<[AnimeDomainModel], Error> {
    return _remoteDataSource.execute(request: request)
      .map { _mapper.transformResponseToEntity(request: request, response: $0) }
      .flatMap { result -> AnyPublisher<[AnimeDomainModel], Error> in
        _localeDataSource.add(entities: result)
          .filter { $0 }
          .map { _ in _mapper.transformEntityToDomain(entity: result) }
          .eraseToAnyPublisher()
      }
      .map { _mapper.transformEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }

}
