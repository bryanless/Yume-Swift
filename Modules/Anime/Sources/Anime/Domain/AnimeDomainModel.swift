//
//  AnimeDomainModel.swift
//  
//
//  Created by Bryan on 06/01/23.
//

public struct AnimeDomainModel: Equatable, Identifiable {

  public let id: Int
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
  let nsfw: String
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
