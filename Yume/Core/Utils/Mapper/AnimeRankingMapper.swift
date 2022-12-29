//
//  AnimeRankingMapper.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

final class AnimeRankingMapper {

  // MARK: - Top all anime series
  static func mapAnimeRankingResponsesToEntities(
    input animeRankingResponses: [AnimeRankingResponse],
    type rankingType: AnimeRankingParameters.RankingType
  ) -> [AnimeEntity] {
    return animeRankingResponses.map { result in
      let newAnime = AnimeEntity()
      newAnime.id = result.anime.id
      newAnime.title = result.anime.title
      newAnime.mainPicture = result.anime.mainPicture?.medium ?? "Unknown"
      newAnime.alternativeTitleSynonyms.append(objectsIn: result.anime.alternativeTitles?.synonyms ?? [])
      newAnime.alternativeTitleEnglish = result.anime.alternativeTitles?.english ?? "Unknown"
      newAnime.alternativeTitleJapanese = result.anime.alternativeTitles?.japanese ?? "Unknown"
      newAnime.startDate = result.anime.startDate ?? ""
      newAnime.endDate = result.anime.endDate ?? ""
      newAnime.synopsis = result.anime.synopsis ?? "Unknown"
      newAnime.rating = result.anime.rating ?? 0
      newAnime.rank = result.anime.rank ?? 0
      newAnime.popularity = result.anime.popularity ?? 0
      newAnime.userAmount = result.anime.userAmount
      newAnime.genre.append(objectsIn: result.anime.genres.map { $0.name })
      newAnime.mediaType = result.anime.mediaType.toName().rawValue
      newAnime.status = result.anime.status.name
      newAnime.episodeAmount = result.anime.episodeAmount
      newAnime.startSeason = result.anime.startSeason.season.name
      newAnime.startSeasonYear = result.anime.startSeason.year.description
      newAnime.source = result.anime.source?.name ?? "Unknown"
      newAnime.episodeDuration = result.anime.episodeDuration
      newAnime.studios.append(objectsIn: result.anime.studios.map { $0.name })
      switch rankingType {
      case .all:
        newAnime.ranking?.rankingAll = result.ranking.rank
      case .airing:
        newAnime.ranking?.rankingAiring = result.ranking.rank
      case .upcoming:
        newAnime.ranking?.rankingUpcoming = result.ranking.rank
      case .tv:
        newAnime.ranking?.rankingTv = result.ranking.rank
      case .ova:
        newAnime.ranking?.rankingOva = result.ranking.rank
      case .movie:
        newAnime.ranking?.rankingMovie = result.ranking.rank
      case .special:
        newAnime.ranking?.rankingSpecial = result.ranking.rank
      case .byPopularity:
        newAnime.ranking?.rankingPopularity = result.ranking.rank
      case .favorite:
        newAnime.ranking?.rankingFavorite = result.ranking.rank
      }
      return newAnime
    }
  }

  static func mapAnimeEntitiesToDomains(
    input animeEntities: [AnimeEntity]
  ) -> [AnimeModel] {
    return animeEntities.map { result in
      return AnimeModel(
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
        genre: Array(result.genre),
        mediaType: result.mediaType,
        status: result.status,
        episodeAmount: result.episodeAmount,
        startSeason: result.startSeason,
        startSeasonYear: result.startSeasonYear,
        source: result.source,
        episodeDuration: result.episodeDuration,
        studios: Array(result.studios),
        ranking: mapAnimeRankingEntityToDomains(input: result.ranking ?? AnimeRankingEntity()),
        isFavorite: result.isFavorite
      )
    }
  }

  private static func mapAnimeRankingEntityToDomains(
    input animeRankingEntity: AnimeRankingEntity
  ) -> AnimeRankingModel {
    return AnimeRankingModel(
      rankingAll: animeRankingEntity.rankingAll,
      rankingAiring: animeRankingEntity.rankingAiring,
      rankingUpcoming: animeRankingEntity.rankingUpcoming,
      rankingTv: animeRankingEntity.rankingTv,
      rankingOva: animeRankingEntity.rankingOva,
      rankingMovie: animeRankingEntity.rankingMovie,
      rankingSpecial: animeRankingEntity.rankingSpecial,
      rankingPopularity: animeRankingEntity.rankingPopularity,
      rankingFavorite: animeRankingEntity.rankingFavorite
    )
  }

  // MARK: - Response to Domain Mapper
  /// For UI preview only
  static func mapAnimeRankingResponsesToDomains(
    input animeRankingResponses: [AnimeRankingResponse]
  ) -> [AnimeModel] {

    return animeRankingResponses.map { result in
      return AnimeModel(
        id: result.anime.id,
        title: result.anime.title,
        mainPicture: result.anime.mainPicture?.medium ?? "Unknown",
        alternativeTitleSynonyms: result.anime.alternativeTitles?.synonyms ?? [],
        alternativeTitleEnglish: result.anime.alternativeTitles?.english ?? "Unknown",
        alternativeTitleJapanese: result.anime.alternativeTitles?.japanese ?? "Unknown",
        startDate: result.anime.startDate ?? "",
        endDate: result.anime.endDate ?? "",
        synopsis: result.anime.synopsis ?? "Unknown",
        rating: result.anime.rating ?? 0,
        rank: result.anime.rank ?? 0,
        popularity: result.anime.popularity ?? 0,
        userAmount: result.anime.userAmount,
        genre: result.anime.genres.map { $0.name },
        mediaType: result.anime.mediaType.toName().rawValue,
        status: result.anime.status.name,
        episodeAmount: result.anime.episodeAmount,
        startSeason: result.anime.startSeason.season.name,
        startSeasonYear: result.anime.startSeason.year.description,
        source: result.anime.source?.name ?? "Unknown",
        episodeDuration: result.anime.episodeDuration,
        studios: result.anime.studios.map { $0.name },
        ranking: mapAnimeRankingResponseToDomains(input: result.ranking),
        isFavorite: false

      )
    }
  }

  /// For UI preview only
  private static func mapAnimeRankingResponseToDomains(input animeRankingResponse: Ranking) -> AnimeRankingModel {
    return AnimeRankingModel(
      rankingAll: animeRankingResponse.rank,
      rankingAiring: animeRankingResponse.rank,
      rankingUpcoming: animeRankingResponse.rank,
      rankingTv: animeRankingResponse.rank,
      rankingOva: animeRankingResponse.rank,
      rankingMovie: animeRankingResponse.rank,
      rankingSpecial: animeRankingResponse.rank,
      rankingPopularity: animeRankingResponse.rank,
      rankingFavorite: animeRankingResponse.rank
    )
  }

}
