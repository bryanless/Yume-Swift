//
//  AnimeListModuleRequest.swift
//  
//
//  Created by Bryan on 08/01/23.
//

public struct AnimeListModuleRequest: Encodable {
  let q: String
  let limit: Int
  let offset: Int
  let fields: String
  let nsfw: Bool

  public init(
    title q: String,
    limit: Int = 100,
    offset: Int = 0,
    fields: String = "alternative_titles,start_date,end_date,synopsis,mean,"
    + "rank,popularity,num_list_users,num_favorites,genres,media_type,"
    + "status,num_episodes,start_season,source,average_episode_duration,studios",
    nsfw: Bool = true
  ) {
    self.q = q
    self.limit = limit
    self.offset = offset
    self.fields = fields
    self.nsfw = nsfw
  }
}
