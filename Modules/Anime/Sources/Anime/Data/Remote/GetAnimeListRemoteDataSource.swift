//
//  GetAnimeListRemoteDataSource.swift
//  
//
//  Created by Bryan on 09/01/23.
//

import Alamofire
import Core
import Combine
import Foundation

public struct GetAnimeListRemoteDataSource: DataSource {

  public typealias Request = AnimeListRequest
  public typealias Response = [AnimeDataResponse]

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

  public func execute(request: AnimeListRequest?) -> AnyPublisher<[AnimeDataResponse], Error> {
    return Future<[AnimeDataResponse], Error> { completion in
      guard let request = request else {
        return completion(.failure(URLError.invalidRequest))
      }

      let remoteRequest = AnimeListRemoteRequest(
        title: request.q,
        limit: request.limit,
        offset: request.offset,
        fields: request.fields,
        nsfw: request.nsfw
      )

      if let url = URL(string: _endpoint) {
        AF.request(
          url,
          parameters: remoteRequest,
          encoder: _encoder,
          headers: _headers
        )
        .validate()
        .responseDecodable(of: AnimesResponse.self) { response in
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
