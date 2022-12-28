//
//  AnimeRankingMapper.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

final class AnimeRankingMapper {

  static func mapAnimeRankingResponsesToEntities(
    input animeRankingResponses: [AnimeRankingResponse]
  ) -> [AnimeEntity] {
    return animeRankingResponses.map { result in
      let newAnime = AnimeEntity()
      newAnime.id = result.anime.id
      newAnime.title = result.anime.title
      newAnime.mainPicture = result.anime.mainPicture?.medium ?? "Unknown"
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
        mainPicture: result.mainPicture
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
        mainPicture: result.anime.mainPicture?.medium ?? "Unknown"
      )
    }
  }

}
