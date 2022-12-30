//
//  AnimeModel.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation

struct AnimeModel: Equatable, Identifiable {

  let id: Int
  let title: String
  let mainPicture: String
  let alternativeTitleSynonyms: [String]
  let alternativeTitleEnglish: String
  let alternativeTitleJapanese: String
  let startDate: String
  let endDate: String
  let synopsis: String
  let rating: Double
  let rank: Int
  let popularity: Int
  let userAmount: Int
  let favoriteAmount: Int
  let genre: [String]
  let mediaType: String
  let status: String
  let episodeAmount: Int
  let startSeason: String
  let startSeasonYear: String
  let source: String
  let episodeDuration: Int
  let studios: [String]
  var isFavorite: Bool

}
