//
//  GetAnimeRankingRemoteDataSource.swift
//  
//
//  Created by Bryan on 06/01/23.
//

import Alamofire
import Core
import Combine
import Foundation

public struct GetAnimeRankingRemoteDataSource: DataSource {
  
  public typealias Request = AnimeRankingModuleRequest
  public typealias Response = [AnimeRankingResponse]

  private let _endpoint: String
  private let _encoder: ParameterEncoder
  private let _headers: HTTPHeaders

  public init(
    endpoint: String,
    encoder: ParameterEncoder,
    headers: HTTPHeaders
  ) {
    _endpoint = endpoint
    _encoder = encoder
    _headers = headers
  }

  public func execute(request: AnimeRankingModuleRequest?) -> AnyPublisher<[AnimeRankingResponse], Error> {
    return Future<[AnimeRankingResponse], Error> { completion in
      guard let request = request else { return completion(.failure(URLError.invalidRequest)) }

      if let url = URL(string: "https://api.myanimelist.net/v2/anime/ranking") {
        AF.request(
          url,
          parameters: request,
          encoder: _encoder,
          headers: ["X-MAL-CLIENT-ID": "23edfd1bf4b15809b72c7268fc63bd74"]
        )
        .validate()
        .responseDecodable(of: AnimeRankingsResponse.self) { response in
          debugPrint(response)
          switch response.result {
          case .success(let value):
            completion(.success(value.animes))
          case .failure:
            completion(.failure(URLError.invalidResponse))
          }
        }
      }
    }.eraseToAnyPublisher()
  }

}