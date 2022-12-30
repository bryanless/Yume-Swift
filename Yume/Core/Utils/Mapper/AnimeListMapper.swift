//
//  AnimeListMapper.swift
//  Yume
//
//  Created by Bryan on 30/12/22.
//

final class AnimeListMapper {

  // MARK: - Response to Domain Mapper
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
        startSeason: result.anime.startSeason?.season.name ?? Season.spring.name,
        startSeasonYear: result.anime.startSeason?.year.description ?? "",
        source: result.anime.source?.name ?? "Unknown",
        episodeDuration: result.anime.episodeDuration ?? 0,
        studios: result.anime.studios.map { $0.name },
        isFavorite: false
      )
    }
  }

}
