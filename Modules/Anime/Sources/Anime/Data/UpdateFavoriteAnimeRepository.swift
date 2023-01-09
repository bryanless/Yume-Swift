//
//  UpdateFavoriteAnimeRepository.swift
//  
//
//  Created by Bryan on 07/01/23.
//

import Combine
import Core

public struct UpdateFavoriteAnimeRepository<
  AnimeLocaleDataSource: LocaleDataSource,
  Transformer: Mapper>: Repository
where AnimeLocaleDataSource.Request == Int,
      AnimeLocaleDataSource.Response == AnimeModuleEntity,
      Transformer.Request == Any,
      Transformer.Response == AnimeDataResponse,
      Transformer.Entity == AnimeModuleEntity,
      Transformer.Domain == AnimeDomainModel {

  public typealias Request = Int
  public typealias Response = AnimeDomainModel

  private let _localeDataSource: AnimeLocaleDataSource
  private let _mapper: Transformer

  public init(
    localeDataSource: AnimeLocaleDataSource,
    mapper: Transformer) {
      _localeDataSource = localeDataSource
      _mapper = mapper
    }

  public func execute(request: Int?) -> AnyPublisher<AnimeDomainModel, Error> {
    guard let request = request else {
      fatalError("Request cannot be empty")
    }

    return _localeDataSource.get(id: request)
      .map { _mapper.transformEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }
}
