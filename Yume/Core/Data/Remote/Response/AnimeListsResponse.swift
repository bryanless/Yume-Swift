//
//  AnimeListsResponse.swift
//  Yume
//
//  Created by Bryan on 30/12/22.
//

// MARK: - AnimeListsResponse
struct AnimeListsResponse: Codable {
  let animes: [AnimeListResponse]

  enum CodingKeys: String, CodingKey {
    case animes = "data"
  }
}

// MARK: - AnimeRankingResponse
struct AnimeListResponse: Codable {
  let anime: AnimeResponse

  enum CodingKeys: String, CodingKey {
    case anime = "node"
  }
}
