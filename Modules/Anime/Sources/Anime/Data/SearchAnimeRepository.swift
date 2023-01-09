//
//  SearchAnimeRepository.swift
//  
//
//  Created by Bryan on 09/01/23.
//

import Combine
import Core

public struct SearchAnimeRepository<
  RemoteDataSource: DataSource,
  Transformer: Mapper>: Repository
where RemoteDataSource.Request == AnimeListModuleRequest,
      RemoteDataSource.Response == [AnimeDataResponse],
      Transformer.Request == Any,
      Transformer.Response == [AnimeDataResponse],
      Transformer.Entity == [AnimeModuleEntity],
      Transformer.Domain == [AnimeDomainModel] {

  public typealias Request = AnimeListModuleRequest
  public typealias Response = [AnimeDomainModel]

  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer

  public init(
    remoteDataSource: RemoteDataSource,
    mapper: Transformer) {
      _remoteDataSource = remoteDataSource
      _mapper = mapper
    }

  public func execute(request: AnimeListModuleRequest?) -> AnyPublisher<[AnimeDomainModel], Error> {
    return _remoteDataSource.execute(request: request)
      .map { _mapper.transformResponseToEntity(request: request, response: $0) }
      .map { _mapper.transformEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }

}
