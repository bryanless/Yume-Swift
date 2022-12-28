//
//  AnimeRepository.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation
import Combine

protocol AnimeRepositoryProtocol {

  func getTopAllAnimes() -> AnyPublisher<[AnimeModel], Error>
  func getPopularAnimes() -> AnyPublisher<[AnimeModel], Error>

}

final class AnimeRepository: NSObject {

  typealias AnimeInstance = (LocaleDataSource, RemoteDataSource) -> AnimeRepository

  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSource

  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.locale = locale
    self.remote = remote
  }

  static let sharedInstance: AnimeInstance = { localeRepo, remoteRepo in
    return AnimeRepository(locale: localeRepo, remote: remoteRepo)
  }

}

extension AnimeRepository: AnimeRepositoryProtocol {

  func getTopAllAnimes() -> AnyPublisher<[AnimeModel], Error> {
    return self.locale.getTopAllAnimes()
      .flatMap { result -> AnyPublisher<[AnimeModel], Error> in
        if result.isEmpty {
          return self.remote.getTopAllAnimes()
            .map { AnimeRankingMapper.mapAnimeRankingResponsesToEntities(input: $0) }
            .flatMap { self.locale.addTopAllAnimes(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getTopAllAnimes()
                .map { AnimeRankingMapper.mapAnimeEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getTopAllAnimes()
            .map { AnimeRankingMapper.mapAnimeEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

  func getPopularAnimes() -> AnyPublisher<[AnimeModel], Error> {
    return self.locale.getPopularAnimes()
      .flatMap { result -> AnyPublisher<[AnimeModel], Error> in
        if result.isEmpty {
          return self.remote.getPopularAnimes()
            .map { AnimeRankingMapper.mapAnimeRankingResponsesToPopularAnimeEntities(input: $0) }
            .flatMap { self.locale.addPopularAnimes(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getPopularAnimes()
                .map { AnimeRankingMapper.mapPopularAnimeEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getPopularAnimes()
            .map { AnimeRankingMapper.mapPopularAnimeEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

}
