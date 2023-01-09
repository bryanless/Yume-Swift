//
//  GetFavoriteAnimesRepository.swift
//  
//
//  Created by Bryan on 07/01/23.
//

import Core
import Combine

public struct GetFavoriteAnimesRepository<
  GetFavoriteAnimeLocaleDataSource: LocaleDataSource,
  Transformer: Mapper>: Repository
where GetFavoriteAnimeLocaleDataSource.Request == Int,
      GetFavoriteAnimeLocaleDataSource.Response == AnimeModuleEntity,
      Transformer.Request == Any,
      Transformer.Response == [AnimeDataResponse],
      Transformer.Entity == [AnimeModuleEntity],
      Transformer.Domain == [AnimeDomainModel] {

  public typealias Request = Int
  public typealias Response = [AnimeDomainModel]

  private let _localeDataSource: GetFavoriteAnimeLocaleDataSource
  private let _mapper: Transformer

  public init(
    localeDataSource: GetFavoriteAnimeLocaleDataSource,
    mapper: Transformer) {

      _localeDataSource = localeDataSource
      _mapper = mapper
    }

  public func execute(request: Int?) -> AnyPublisher<[AnimeDomainModel], Error> {
    return _localeDataSource.list(request: nil)
      .map { _mapper.transformEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }
}
