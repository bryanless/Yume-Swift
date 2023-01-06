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

  func getTopAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeRankingResponse], Error>
  func searchAnime(request: AnimeListRequest) -> AnyPublisher<[AnimeListResponse], Error>

}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {

  func getTopAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeRankingResponse], Error> {
    return Future<[AnimeRankingResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.ranking.url) {
        AF.request(
          url,
          parameters: AnimeRankingRequestParameter(
            type: request.rankingType,
            limit: request.limit,
            offset: request.offset,
            fields: request.fields
          ),
          encoder: API.encoder,
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

  func searchAnime(request: AnimeListRequest) -> AnyPublisher<[AnimeListResponse], Error> {
    return Future<[AnimeListResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.search.url) {
        AF.request(
          url,
          parameters: request,
          encoder: API.encoder,
          headers: API.headers
        )
        .validate()
        .responseDecodable(of: AnimeListsResponse.self) { response in
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
