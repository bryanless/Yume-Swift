//
//  GetAnimeRepository.swift
//  
//
//  Created by Bryan on 07/01/23.
//

import Combine
import Core

public struct GetAnimeRepository<
  AnimeLocaleDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper>: Repository
where AnimeLocaleDataSource.Request == Int,
      AnimeLocaleDataSource.Response == AnimeModuleEntity,
      RemoteDataSource.Request == AnimeRequest,
      RemoteDataSource.Response == AnimeResponse,
      Transformer.Request == Any,
      Transformer.Response == AnimeResponse,
      Transformer.Entity == AnimeModuleEntity,
      Transformer.Domain == AnimeDomainModel {

  public typealias Request = AnimeRequest
  public typealias Response = AnimeDomainModel

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

  public func execute(request: AnimeRequest?) -> AnyPublisher<AnimeDomainModel, Error> {
    guard let request = request else {
      fatalError("Request cannot be empty")
    }

    return _localeDataSource.get(id: request.animeId)
      .flatMap { entity -> AnyPublisher<AnimeDomainModel, Error> in
        // Refresh anime if cached more than 24 hours
        if entity.updatedAt.isExpired() {
          return _remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToEntity(request: request, response: $0) }
            .flatMap { _localeDataSource.add(entities: [$0]) }
            .filter { $0 }
            .flatMap { _ in _localeDataSource.get(id: request.animeId)
                .map { _mapper.transformEntityToDomain(entity: $0) }
            }
            .catch { _ in
              return _localeDataSource.get(id: request.animeId)
                .map { _mapper.transformEntityToDomain(entity: $0) }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        } else {
          return _localeDataSource.get(id: request.animeId)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }
      .catch { _ in
        return _remoteDataSource.execute(request: request)
          .map { _mapper.transformResponseToEntity(request: request, response: $0) }
          .flatMap { _localeDataSource.add(entities: [$0]) }
          .filter { $0 }
          .flatMap { _ in _localeDataSource.get(id: request.animeId)
              .map { _mapper.transformEntityToDomain(entity: $0) }
          }
          .eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
  }

}
