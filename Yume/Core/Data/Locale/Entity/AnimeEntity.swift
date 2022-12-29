//
//  AnimeEntity.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation
import RealmSwift

class AnimeEntity: Object {

  @Persisted(primaryKey: true) var id: Int = 0
  @Persisted var title: String = ""
  @Persisted var mainPicture: String = ""
  @Persisted var alternativeTitleSynonyms: List<String> = List<String>()
  @Persisted var alternativeTitleEnglish: String = ""
  @Persisted var alternativeTitleJapanese: String = ""
  @Persisted var startDate: String = ""
  @Persisted var endDate: String = ""
  @Persisted var synopsis: String = ""
  @Persisted var rating: Double = 0
  @Persisted var rank: Int = 0
  @Persisted var popularity: Int = 0
  @Persisted var userAmount: Int = 0
  @Persisted var genre: List<String> = List<String>()
  @Persisted var mediaType: String = ""
  @Persisted var status: String = ""
  @Persisted var episodeAmount: Int = 0
  @Persisted var startSeason: String = ""
  @Persisted var startSeasonYear: String = ""
  @Persisted var source: String = ""
  @Persisted var episodeDuration: Int = 0
  @Persisted var studios: List<String> = List<String>()
  @Persisted var ranking: AnimeRankingEntity? = AnimeRankingEntity()
  @Persisted var isFavorite: Bool = false

}

class AnimeRankingEntity: EmbeddedObject {
  @Persisted var rankingAll: Int = 0
  @Persisted var rankingAiring: Int = 0
  @Persisted var rankingUpcoming: Int = 0
  @Persisted var rankingTv: Int = 0
  @Persisted var rankingOva: Int = 0
  @Persisted var rankingMovie: Int = 0
  @Persisted var rankingSpecial: Int = 0
  @Persisted var rankingPopularity: Int = 0
  @Persisted var rankingFavorite: Int = 0
}
