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

  private var apiKey: String {
    guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
      fatalError("Couldn't find file 'Info.plist'.")
    }

    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
    }

    return value
  }

  func getHeaders() -> HTTPHeaders {
    return ["X-MAL-CLIENT-ID": apiKey]
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

struct AnimeListParameters {
  static func getAnimeListParameters(query: String) -> [String: String] {
    return [
      "q": query,
      "fields": API.defaultFields
    ]
  }
}

struct AnimeRankingParameters {
  static func getAnimeRankingParameters(_ rankingType: RankingType) -> [String: String] {
    return [
      "ranking_type": rankingType.name,
      "fields": API.defaultFields
    ]
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
  }
}
