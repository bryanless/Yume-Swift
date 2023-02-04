//
//  GetAnimeRemoteDataSource.swift
//  
//
//  Created by Bryan on 09/01/23.
//

import Alamofire
import Core
import Combine
import Foundation

public struct GetAnimeRemoteDataSource: DataSource {

  public typealias Request = AnimeRequest
  public typealias Response = AnimeResponse

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

  public func execute(request: AnimeRequest?) -> AnyPublisher<AnimeResponse, Error> {
    return Future<AnimeResponse, Error> { completion in
      guard let request = request else {
        return completion(.failure(URLError.invalidRequest))
      }

      if let url = URL(string: "\(_endpoint)/\(request.animeId)") {
        AF.request(
          url,
          parameters: request,
          encoder: _encoder,
          headers: _headers
        )
        .validate()
        .responseDecodable(of: AnimeResponse.self) { response in
          switch response.result {
          case .success(let value):
            completion(.success(value))
          case .failure(let error):
            if let error = error.underlyingError as? Foundation.URLError, error.code == .notConnectedToInternet {
              // No internet connection
              completion(.failure(URLError.notConnectedToInternet))
            } else {
              completion(.failure(URLError.invalidResponse))
            }
          }
        }
      }
    }.eraseToAnyPublisher()
  }

}
