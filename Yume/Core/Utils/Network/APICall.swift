//
//  APICall.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation

struct API {

  static let baseUrl = "https://api.myanimelist.net/v2/"

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
