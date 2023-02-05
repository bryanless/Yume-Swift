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
  static let encoder = URLEncodedFormParameterEncoder(encoder: URLEncodedFormEncoder(keyEncoding: .convertToSnakeCase))
  static var headers: HTTPHeaders {
    guard let apiKey = File.loadDictionaryKey(forKey: "API_KEY", forResource: "Keys", ofType: "plist") as? String else {
      fatalError("Value of 'API_KEY' in 'Keys.plist' is not a String")
    }

    guard !apiKey.starts(with: "_") else {
      fatalError("Create a MyAnimeList account and get a Client ID (API key) at https://myanimelist.net/apiconfig.")
    }

    return ["X-MAL-CLIENT-ID": apiKey]
  }

}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {

  enum Gets: Endpoint {
    case detail
    case ranking
    case search

    public var url: String {
      switch self {
      case .detail: return "\(API.baseUrl)anime"
      case .ranking: return "\(API.baseUrl)anime/ranking"
      case .search: return "\(API.baseUrl)anime"
      }
    }
  }

}
