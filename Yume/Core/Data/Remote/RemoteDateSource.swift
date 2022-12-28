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
          parameters: [
            "ranking_type": "all",
            "fields": "alternative_titles,start_date,end_date,synopsis,mean,rank,popularity,num_list_users,genres,media_type,status,num_episodes,start_season,source,average_episode_duration,studios"
          ],
          headers: ["X-MAL-CLIENT-ID": "23edfd1bf4b15809b72c7268fc63bd74"]
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
