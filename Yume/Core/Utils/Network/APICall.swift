//
//  APICall.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation
import Alamofire

struct API {

  static let baseUrl = "https://api.myanimelist.net/v2/"
  static let defaultFields = "alternative_titles,start_date,end_date,synopsis,mean,"
  + "rank,popularity,num_list_users,num_favorites,genres,media_type,"
  + "status,num_episodes,start_season,source,average_episode_duration,studios"
  static let encoder = URLEncodedFormParameterEncoder(encoder: URLEncodedFormEncoder(keyEncoding: .convertToSnakeCase))
  static var headers: HTTPHeaders {
    guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
      fatalError("Couldn't find file 'Info.plist'.")
    }

    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
    }

    return ["X-MAL-CLIENT-ID": value]
  }

}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {

  enum Gets: Endpoint {
    case ranking
    case search

    public var url: String {
      switch self {
      case .ranking: return "\(API.baseUrl)anime/ranking"
      case .search: return "\(API.baseUrl)anime"
      }
    }
  }

}

enum RankingType: String {
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

struct AnimeRankingRequest {
  let rankingType: RankingType
  let limit: Int
  let offsets: Int
  let fields: String
  let nsfw: Bool

  init(
    type rankingType: RankingType = .all,
    limit: Int = 20,
    offsets: Int = 0,
    fields: String = API.defaultFields,
    nsfw: Bool = false
  ) {
    self.rankingType = rankingType
    self.limit = limit
    self.offsets = offsets
    self.fields = fields
    self.nsfw = nsfw
  }
}

struct AnimeRankingRequestParameter: Encodable {
  let rankingType: String
  let limit: Int
  let offsets: Int
  let fields: String
  let nsfw: Bool

  init(
    type rankingType: RankingType = .all,
    limit: Int = 20,
    offsets: Int = 0,
    fields: String = API.defaultFields,
    nsfw: Bool = false
  ) {
    self.rankingType = rankingType.name
    self.limit = limit
    self.offsets = offsets
    self.fields = fields
    self.nsfw = nsfw
  }
}

struct AnimeListParameters {
  static func getAnimeListParameters(query: String) -> [String: String] {
    return [
      "q": query,
      "fields": API.defaultFields
    ]
  }
}
