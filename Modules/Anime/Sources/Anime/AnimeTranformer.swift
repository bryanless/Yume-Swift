//
//  AnimeTransformer.swift
//  
//
//  Created by Bryan on 06/01/23.
//

import Core

public struct AnimeTransformer: Mapper {
  public typealias Request = Any
  public typealias Response = [AnimeRankingResponse]
  public typealias Entity = [AnimeModuleEntity]
  public typealias Domain = [AnimeDomainModel]

  public init() {}

  public func transformResponseToEntity(request: Any?, response: [AnimeRankingResponse]) -> Entity {
    return response.map { result in
      let newAnime = AnimeModuleEntity()
      newAnime.id = result.anime.id
      newAnime.title = result.anime.title
      newAnime.mainPicture = result.anime.mainPicture?.medium ?? "Unknown"
      newAnime.alternativeTitleSynonyms.append(objectsIn: result.anime.alternativeTitles?.synonyms ?? [])
      newAnime.alternativeTitleEnglish = result.anime.alternativeTitles?.english ?? "Unknown"
      newAnime.alternativeTitleJapanese = result.anime.alternativeTitles?.japanese ?? "Unknown"
      newAnime.startDate = result.anime.startDate ?? "Unknown"
      newAnime.endDate = result.anime.endDate ?? "Unknown"
      newAnime.synopsis = result.anime.synopsis ?? "Unknown"
      newAnime.rating = result.anime.rating ?? 0
      newAnime.rank = result.anime.rank ?? 0
      newAnime.popularity = result.anime.popularity ?? 0
      newAnime.userAmount = result.anime.userAmount
      newAnime.favoriteAmount = result.anime.favoriteAmount
      newAnime.nsfw = result.anime.nsfw?.name ?? "Unknown"
      newAnime.genre.append(objectsIn: result.anime.genres?.map { $0.name } ?? [])
      newAnime.mediaType = result.anime.mediaType.name
      newAnime.status = result.anime.status.name
      newAnime.episodeAmount = result.anime.episodeAmount
      newAnime.startSeason = result.anime.startSeason?.season.name ?? "Unknown"
      newAnime.startSeasonYear = result.anime.startSeason?.year.description ?? ""
      newAnime.source = result.anime.source?.name ?? "Unknown"
      newAnime.episodeDuration = result.anime.episodeDuration ?? 0
      newAnime.studios.append(objectsIn: result.anime.studios.map { $0.name })
      return newAnime
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
        studios: Array(result.studios),
        isFavorite: result.isFavorite
      )
    }
  }

}
