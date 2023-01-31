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
