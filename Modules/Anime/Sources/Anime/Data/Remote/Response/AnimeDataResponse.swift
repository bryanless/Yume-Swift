//
//  AnimeRankingResponse.swift
//  
//
//  Created by Bryan on 06/01/23.
//

// MARK: - AnimeRankingResponse
public struct AnimesResponse: Codable {
  let animes: [AnimeDataResponse]

  private enum CodingKeys: String, CodingKey {
    case animes = "data"
  }
}

// MARK: - AnimeRankingResponse
public struct AnimeDataResponse: Codable {
  let anime: AnimeResponse

  private enum CodingKeys: String, CodingKey {
    case anime = "node"
  }
}

// MARK: - Ranking
public struct Ranking: Codable {
  let rank: Int
}
