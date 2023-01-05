//
//  AnimeMapper.swift
//  Yume
//
//  Created by Bryan on 30/12/22.
//

final class AnimeMapper {

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

  static func mapAnimeEntityToDomain(
    input result: AnimeEntity
  ) -> AnimeModel {
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
