//
//  AnimeRankingModuleRequest.swift
//  
//
//  Created by Bryan on 06/01/23.
//

public struct AnimeRankingModuleRequest: Encodable {
  let rankingType: String
  let limit: Int
  let offset: Int
  let fields: String
  let nsfw: Bool

  public init(
    type rankingType: String,
    limit: Int = 20,
    offset: Int = 0,
    fields: String = "alternative_titles,start_date,end_date,synopsis,mean,"
    + "rank,popularity,num_list_users,num_favorites,genres,media_type,"
    + "status,num_episodes,start_season,source,average_episode_duration,studios",
    nsfw: Bool = true
  ) {
    self.rankingType = rankingType
    self.limit = limit
    self.offset = offset
    self.fields = fields
    self.nsfw = nsfw
  }
}

public enum RankingTypeRequest: String {
  case all
  case airing
  case upcoming
  case tv
  case ova
  case movie
  case special
  case byPopularity
  case favorite

  var name: String {
    return rawValue.lowercased()
  }

  var sortKey: String {
    switch self {
    case .all, .airing, .tv, .ova, .movie, .special:
      return "rank"
    case .upcoming, .byPopularity:
      return "popularity"
    case .favorite:
      return "favoriteAmount"
    }
  }
}
