//
//  AnimeRankingsResponse.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation

// MARK: - AnimeRankingsResponse
struct AnimeRankingsResponse: Codable {
  let animes: [AnimeRankingResponse]

  enum CodingKeys: String, CodingKey {
    case animes = "data"
  }
}

// MARK: - AnimeRankingResponse
struct AnimeRankingResponse: Codable {
  let anime: AnimeResponse
  let ranking: Ranking

  enum CodingKeys: String, CodingKey {
    case anime = "node"
    case ranking
  }
}

// MARK: - Ranking
struct Ranking: Codable {
  let rank: Int
}
