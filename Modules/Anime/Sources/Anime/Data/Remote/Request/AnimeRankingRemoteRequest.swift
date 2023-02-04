//
//  AnimeRankingRemoteRequest.swift
//  
//
//  Created by Bryan on 01/02/23.
//

public struct AnimeRankingRemoteRequest: Encodable {
  let rankingType: String
  let limit: Int
  let offset: Int
  let fields: String
  let nsfw: Bool

  public init(
    type rankingType: String,
    limit: Int?,
    offset: Int?,
    fields: String?,
    nsfw: Bool?
  ) {
    self.rankingType = rankingType
    self.limit = limit ?? 20
    self.offset = offset ?? 0
    self.fields = fields ?? (
      "alternative_titles,start_date,end_date,synopsis,mean,"
      + "rank,popularity,num_list_users,num_favorites,genres,media_type,"
      + "status,num_episodes,start_season,source,average_episode_duration,studios"
    )
    self.nsfw = nsfw ?? true
  }
}
