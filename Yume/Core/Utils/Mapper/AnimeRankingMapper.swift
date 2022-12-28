//
//  AnimeRankingMapper.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

final class AnimeRankingMapper {

  // MARK: - Top all anime series
  static func mapAnimeRankingResponsesToEntities(
    input animeRankingResponses: [AnimeRankingResponse]
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
        studios: Array(result.studios)
      )
    }
  }

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
        studios: result.anime.studios.map { $0.name }
      )
    }
  }

  // MARK: - Popular anime
  static func mapAnimeRankingResponsesToPopularAnimeEntities(
    input animeRankingResponses: [AnimeRankingResponse]
  ) -> [PopularAnimeEntity] {
    return animeRankingResponses.map { result in
      let newAnime = PopularAnimeEntity()
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
      return newAnime
    }
  }

  static func mapPopularAnimeEntitiesToDomains(
    input popularAnimeEntities: [PopularAnimeEntity]
  ) -> [AnimeModel] {
    return popularAnimeEntities.map { result in
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
        studios: Array(result.studios)
      )
    }
  }

}
