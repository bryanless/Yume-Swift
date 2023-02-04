//
//  AnimesTransformer.swift
//  
//
//  Created by Bryan on 06/01/23.
//

import Core
import Foundation

public struct AnimesTransformer: Mapper {
  public typealias Request = Any
  public typealias Response = [AnimeDataResponse]
  public typealias Entity = [AnimeModuleEntity]
  public typealias Domain = [AnimeDomainModel]

  public init() {}

  public func transformResponseToEntity(request: Any?, response: [AnimeDataResponse]) -> Entity {
    return response.map { result in
      let animeEntity = AnimeModuleEntity()
      animeEntity.id = result.anime.id
      animeEntity.title = result.anime.title
      animeEntity.mainPicture = result.anime.mainPicture?.medium ?? "Unknown"
      animeEntity.alternativeTitleSynonyms.append(objectsIn: result.anime.alternativeTitles?.synonyms ?? [])
      animeEntity.alternativeTitleEnglish = result.anime.alternativeTitles?.english ?? "Unknown"
      animeEntity.alternativeTitleJapanese = result.anime.alternativeTitles?.japanese ?? "Unknown"
      animeEntity.startDate = result.anime.startDate ?? "Unknown"
      animeEntity.endDate = result.anime.endDate ?? "Unknown"
      animeEntity.synopsis = result.anime.synopsis ?? "Unknown"
      animeEntity.rating = result.anime.rating ?? 0
      animeEntity.rank = result.anime.rank ?? 0
      animeEntity.popularity = result.anime.popularity ?? 0
      animeEntity.userAmount = result.anime.userAmount
      animeEntity.favoriteAmount = result.anime.favoriteAmount
      animeEntity.nsfw = result.anime.nsfw?.name ?? "Unknown"
      animeEntity.genre.append(objectsIn: result.anime.genres?.map { $0.name } ?? [])
      animeEntity.mediaType = result.anime.mediaType.name
      animeEntity.status = result.anime.status.name
      animeEntity.episodeAmount = result.anime.episodeAmount
      animeEntity.startSeason = result.anime.startSeason?.season.name ?? "Unknown"
      animeEntity.startSeasonYear = result.anime.startSeason?.year.description ?? ""
      animeEntity.source = result.anime.source?.name ?? "Unknown"
      animeEntity.episodeDuration = result.anime.episodeDuration ?? 0
      animeEntity.studios.append(objectsIn: result.anime.studios.map { $0.name })
      animeEntity.updatedAt = Date()
      return animeEntity
    }
  }

  public func transformEntityToDomain(entity: [AnimeModuleEntity]) -> [AnimeDomainModel] {
    return entity.map { result in
      return AnimeDomainModel(
        id: result.id,
        title: result.title,
        mainPicture: result.mainPicture,
        alternativeTitleSynonyms: Array(result.alternativeTitleSynonyms),
        alternativeTitleEnglish: result.alternativeTitleEnglish,
        alternativeTitleJapanese: result.alternativeTitleJapanese,
        startDate: result.startDate,
        endDate: result.endDate,
        airedDate: AnimeTransformer.transformToAiredDate(startDate: result.startDate, endDate: result.endDate),
        synopsis: result.synopsis,
        rating: result.rating,
        rank: result.rank,
        popularity: result.popularity,
        userAmount: result.userAmount,
        favoriteAmount: result.favoriteAmount,
        nsfw: result.nsfw,
        genre: Array(result.genre),
        mediaType: result.mediaType,
        status: result.status,
        episodeAmount: result.episodeAmount,
        startSeason: result.startSeason,
        startSeasonYear: result.startSeasonYear,
        source: result.source,
        episodeDuration: result.episodeDuration,
        episodeDurationText: AnimeTransformer.transformToDurationText(duration: result.episodeDuration),
        studios: Array(result.studios),
        isFavorite: result.isFavorite
      )
    }
  }

}
