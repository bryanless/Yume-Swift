//
//  AnimeRequest.swift
//  
//
//  Created by Bryan on 09/01/23.
//

public struct AnimeRequest: Encodable {
  let animeId: Int
  let fields: String

  public init(
    id animeId: Int,
    fields: String = "alternative_titles,start_date,end_date,synopsis,mean,"
    + "rank,popularity,num_list_users,num_favorites,genres,media_type,"
    + "status,num_episodes,start_season,source,average_episode_duration,studios"
  ) {
    self.animeId = animeId
    self.fields = fields
  }
}
