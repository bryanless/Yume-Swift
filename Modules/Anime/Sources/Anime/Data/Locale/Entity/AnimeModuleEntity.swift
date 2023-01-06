//
//  AnimeModuleEntity.swift
//  
//
//  Created by Bryan on 06/01/23.
//

import RealmSwift

public class AnimeModuleEntity: Object {

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
  @Persisted var favoriteAmount: Int = 0
  @Persisted var nsfw: String = ""
  @Persisted var genre: List<String> = List<String>()
  @Persisted var mediaType: String = ""
  @Persisted var status: String = ""
  @Persisted var episodeAmount: Int = 0
  @Persisted var startSeason: String = ""
  @Persisted var startSeasonYear: String = ""
  @Persisted var source: String = ""
  @Persisted var episodeDuration: Int = 0
  @Persisted var studios: List<String> = List<String>()
  @Persisted var isFavorite: Bool = false

  public override static func primaryKey() -> String? {
    return "id"
  }

}
