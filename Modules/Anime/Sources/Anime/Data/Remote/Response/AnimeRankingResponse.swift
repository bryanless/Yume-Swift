//
//  AnimeRankingResponse.swift
//  
//
//  Created by Bryan on 06/01/23.
//

// MARK: - AnimeRankingResponse
public struct AnimeRankingsResponse: Codable {
  let animes: [AnimeRankingResponse]

  private enum CodingKeys: String, CodingKey {
    case animes = "data"
  }
}

// MARK: - AnimeRankingResponse
public struct AnimeRankingResponse: Codable {
  let anime: AnimeResponse
  let ranking: Ranking

  private enum CodingKeys: String, CodingKey {
    case anime = "node"
    case ranking
  }
}

// MARK: - Ranking
public struct Ranking: Codable {
  let rank: Int
}
