//
//  AnimeDomainModel.swift
//  
//
//  Created by Bryan on 06/01/23.
//

public struct AnimeDomainModel: Equatable, Identifiable {

  public let id: Int
  public let title: String
  public let mainPicture: String
  public let alternativeTitleSynonyms: [String]
  public let alternativeTitleEnglish: String
  public let alternativeTitleJapanese: String
  public let startDate: String
  public let endDate: String
  public let synopsis: String
  public let rating: Double
  public let rank: Int
  public let popularity: Int
  public let userAmount: Int
  public let favoriteAmount: Int
  public let nsfw: String
  public let genre: [String]
  public let mediaType: String
  public let status: String
  public let episodeAmount: Int
  public let startSeason: String
  public let startSeasonYear: String
  public let source: String
  public let episodeDuration: Int
  public let studios: [String]
  public var isFavorite: Bool

}
