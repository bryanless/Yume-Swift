//
//  RemoteDateSource.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {

  func getTopAllAnimes() -> AnyPublisher<[AnimeRankingResponse], Error>

}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {

  func getTopAllAnimes() -> AnyPublisher<[AnimeRankingResponse], Error> {
    return Future<[AnimeRankingResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.ranking.url) {
        AF.request(
          url,
          parameters: AnimeRankingParameters.getAnimeRankingParameters(.all),
          headers: API.headers
        )
        .validate()
        .responseDecodable(of: AnimeRankingsResponse.self) { response in
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

  func getPopularAnimes() -> AnyPublisher<[AnimeRankingResponse], Error> {
    return Future<[AnimeRankingResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.ranking.url) {
        AF.request(
          url,
          parameters: AnimeRankingParameters.getAnimeRankingParameters(.byPopularity),
          headers: API.headers
        )
        .validate()
        .responseDecodable(of: AnimeRankingsResponse.self) { response in
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
