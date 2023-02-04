//
//  AnimeTransformer.swift
//  
//
//  Created by Bryan on 09/01/23.
//

import Core
import Foundation

public struct AnimeTransformer: Mapper {
  public typealias Request = Any
  public typealias Response = AnimeResponse
  public typealias Entity = AnimeModuleEntity
  public typealias Domain = AnimeDomainModel

  public init() {}

  public func transformResponseToEntity(request: Any?, response: AnimeResponse) -> Entity {
    let animeEntity = AnimeModuleEntity()
    animeEntity.id = response.id
    animeEntity.title = response.title
    animeEntity.mainPicture = response.mainPicture?.medium ?? "Unknown"
    animeEntity.alternativeTitleSynonyms.append(objectsIn: response.alternativeTitles?.synonyms ?? [])
    animeEntity.alternativeTitleEnglish = response.alternativeTitles?.english ?? "Unknown"
    animeEntity.alternativeTitleJapanese = response.alternativeTitles?.japanese ?? "Unknown"
    animeEntity.startDate = response.startDate ?? "Unknown"
    animeEntity.endDate = response.endDate ?? "Unknown"
    animeEntity.synopsis = response.synopsis ?? "Unknown"
    animeEntity.rating = response.rating ?? 0
    animeEntity.rank = response.rank ?? 0
    animeEntity.popularity = response.popularity ?? 0
    animeEntity.userAmount = response.userAmount
    animeEntity.favoriteAmount = response.favoriteAmount
    animeEntity.nsfw = response.nsfw?.name ?? "Unknown"
    animeEntity.genre.append(objectsIn: response.genres?.map { $0.name } ?? [])
    animeEntity.mediaType = response.mediaType.name
    animeEntity.status = response.status.name
    animeEntity.episodeAmount = response.episodeAmount
    animeEntity.startSeason = response.startSeason?.season.name ?? "Unknown"
    animeEntity.startSeasonYear = response.startSeason?.year.description ?? ""
    animeEntity.source = response.source?.name ?? "Unknown"
    animeEntity.episodeDuration = response.episodeDuration ?? 0
    animeEntity.studios.append(objectsIn: response.studios.map { $0.name })
    animeEntity.updatedAt = Date()
    return animeEntity
  }

  public func transformEntityToDomain(entity: AnimeModuleEntity) -> AnimeDomainModel {
    return AnimeDomainModel(
      id: entity.id,
      title: entity.title,
      mainPicture: entity.mainPicture,
      alternativeTitleSynonyms: Array(entity.alternativeTitleSynonyms),
      alternativeTitleEnglish: entity.alternativeTitleEnglish,
      alternativeTitleJapanese: entity.alternativeTitleJapanese,
      startDate: entity.startDate,
      endDate: entity.endDate,
      airedDate: AnimeTransformer.transformToAiredDate(startDate: entity.startDate, endDate: entity.endDate),
      synopsis: entity.synopsis,
      rating: entity.rating,
      rank: entity.rank,
      popularity: entity.popularity,
      userAmount: entity.userAmount,
      favoriteAmount: entity.favoriteAmount,
      nsfw: entity.nsfw,
      genre: Array(entity.genre),
      mediaType: entity.mediaType,
      status: entity.status,
      episodeAmount: entity.episodeAmount,
      startSeason: entity.startSeason,
      startSeasonYear: entity.startSeasonYear,
      source: entity.source,
      episodeDuration: entity.episodeDuration,
      episodeDurationText: AnimeTransformer.transformToDurationText(duration: entity.episodeDuration),
      studios: Array(entity.studios),
      isFavorite: entity.isFavorite
    )
  }

  public static func transformToAiredDate(startDate: String, endDate: String) -> String {
    // Start & end date unknown
    if startDate == "Unknown" && endDate == "Unknown" {
      return "unknown_label".localized(bundle: .module)
    }

    // Start or end date unknown
    let start = startDate == "Unknown"
    ? "unknown_label".localized(bundle: .module)
    : startDate.apiFullStringDateToFullStringDate()
    let end = endDate == "Unknown"
    ? "unknown_label".localized(bundle: .module)
    : endDate.apiFullStringDateToFullStringDate()

    // Start & end date same (mostly for movie)
    if start == end {
      return start
    }

    return "\(start) - \(end)"
  }

  public static func transformToDurationText(duration: Int) -> String {
    let (hours, minutes, _) = duration.secondsToHoursMinutesSeconds()
    return String(
      localized: "number_duration_label \(hours) \(minutes) \(0)",
      bundle: .module)
  }

}
