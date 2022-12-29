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
  let genre: [String]
  let mediaType: String
  let status: String
  let episodeAmount: Int
  let startSeason: String
  let startSeasonYear: String
  let source: String
  let episodeDuration: Int
  let studios: [String]
  let ranking: AnimeRankingModel
  let isFavorite: Bool

}
struct AnimeRankingModel: Equatable {
  let rankingAll: Int
  let rankingAiring: Int
  let rankingUpcoming: Int
  let rankingTv: Int
  let rankingOva: Int
  let rankingMovie: Int
  let rankingSpecial: Int
  let rankingPopularity: Int
  let rankingFavorite: Int
}
