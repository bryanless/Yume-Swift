//
//  AnimeListMapper.swift
//  Yume
//
//  Created by Bryan on 30/12/22.
//

final class AnimeListMapper {

  static func mapAnimeListResponsesToEntities(
    input animeListResponses: [AnimeListResponse]
  ) -> [AnimeEntity] {
    return animeListResponses.map { result in
      let newAnime = AnimeEntity()
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
      newAnime.genre.append(objectsIn: result.anime.genres.map { $0.name })
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

  // MARK: - Response to Domain Mapper
  /// For UI preview only
  static func mapAnimeListResponsesToDomains(
    input animeListsRepsonses: [AnimeListResponse]
  ) -> [AnimeModel] {

    return animeListsRepsonses.map { result in
      return AnimeModel(
        id: result.anime.id,
        title: result.anime.title,
        mainPicture: result.anime.mainPicture?.medium ?? "Unknown",
        alternativeTitleSynonyms: result.anime.alternativeTitles?.synonyms ?? [],
        alternativeTitleEnglish: result.anime.alternativeTitles?.english ?? "Unknown",
        alternativeTitleJapanese: result.anime.alternativeTitles?.japanese ?? "Unknown",
        startDate: result.anime.startDate ?? "Unknown",
        endDate: result.anime.endDate ?? "Unknown",
        synopsis: result.anime.synopsis ?? "Unknown",
        rating: result.anime.rating ?? 0,
        rank: result.anime.rank ?? 0,
        popularity: result.anime.popularity ?? 0,
        userAmount: result.anime.userAmount,
        favoriteAmount: result.anime.favoriteAmount,
        nsfw: result.anime.nsfw?.name ?? "Unknown",
        genre: result.anime.genres.map { $0.name },
        mediaType: result.anime.mediaType.name,
        status: result.anime.status.name,
        episodeAmount: result.anime.episodeAmount,
        startSeason: result.anime.startSeason?.season.name ?? "Unknown",
        startSeasonYear: result.anime.startSeason?.year.description ?? "",
        source: result.anime.source?.name ?? "Unknown",
        episodeDuration: result.anime.episodeDuration ?? 0,
        studios: result.anime.studios.map { $0.name },
        isFavorite: false
      )
    }
  }

}
