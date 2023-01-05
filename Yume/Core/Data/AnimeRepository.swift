//
//  AnimeRepository.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation
import Combine

protocol AnimeRepositoryProtocol {

  func getTopAllAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error>
  func getTopAiringAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error>
  func getTopUpcomingAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error>
  func getPopularAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error>
  func getTopFavoriteAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error>
  func getFavoriteAnimes() -> AnyPublisher<[AnimeModel], Error>
  func getAnime(withId id: Int) -> AnyPublisher<AnimeModel, Error>
  func searchAnime(name: String) -> AnyPublisher<[AnimeModel], Error>
  func updateAnimeFavorite(withId id: Int) -> AnyPublisher<AnimeModel, Error>

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

  func getTopAllAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error> {
    return self.locale.getTopAllAnimes()
      .flatMap { result -> AnyPublisher<[AnimeModel], Error> in
        if result.isEmpty {
          return self.remote.getTopAnimes(request: request)
            .map { AnimeRankingMapper.mapAnimeRankingResponsesToEntities(input: $0, type: .all) }
            .flatMap { self.locale.addAnimes(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getTopAllAnimes()
                .map { AnimeMapper.mapAnimeEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getTopAllAnimes()
            .map { AnimeMapper.mapAnimeEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

  func getTopAiringAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error> {
    return self.locale.getTopAiringAnimes()
      .flatMap { result -> AnyPublisher<[AnimeModel], Error> in
        if result.isEmpty {
          return self.remote.getTopAnimes(request: request)
            .map { AnimeRankingMapper.mapAnimeRankingResponsesToEntities(input: $0, type: .airing) }
            .flatMap { self.locale.addAnimes(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getTopAiringAnimes()
                .map { AnimeMapper.mapAnimeEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getTopAiringAnimes()
            .map { AnimeMapper.mapAnimeEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

  func getTopUpcomingAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error> {
    return self.locale.getTopUpcomingAnimes()
      .flatMap { result -> AnyPublisher<[AnimeModel], Error> in
        if result.isEmpty {
          return self.remote.getTopAnimes(request: request)
            .map { AnimeRankingMapper.mapAnimeRankingResponsesToEntities(input: $0, type: .upcoming) }
            .flatMap { self.locale.addAnimes(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getTopUpcomingAnimes()
                .map { AnimeMapper.mapAnimeEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getTopUpcomingAnimes()
            .map { AnimeMapper.mapAnimeEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

  func getPopularAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error> {
    return self.locale.getPopularAnimes()
      .flatMap { result -> AnyPublisher<[AnimeModel], Error> in
        if result.isEmpty {
          return self.remote.getTopAnimes(request: request)
            .map { AnimeRankingMapper.mapAnimeRankingResponsesToEntities(input: $0, type: .byPopularity) }
            .flatMap { self.locale.addAnimes(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getPopularAnimes()
                .map { AnimeMapper.mapAnimeEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getPopularAnimes()
            .map { AnimeMapper.mapAnimeEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

  func getTopFavoriteAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error> {
    return self.locale.getTopFavoriteAnimes()
      .flatMap { result -> AnyPublisher<[AnimeModel], Error> in
        if result.isEmpty {
          return self.remote.getTopAnimes(request: request)
            .map { AnimeRankingMapper.mapAnimeRankingResponsesToEntities(input: $0, type: .favorite) }
            .flatMap { self.locale.addAnimes(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getTopFavoriteAnimes()
                .map { AnimeMapper.mapAnimeEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getTopFavoriteAnimes()
            .map { AnimeMapper.mapAnimeEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

  func getFavoriteAnimes() -> AnyPublisher<[AnimeModel], Error> {
    return self.locale.getFavoriteAnimes()
      .map { AnimeMapper.mapAnimeEntitiesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }

  func getAnime(withId id: Int) -> AnyPublisher<AnimeModel, Error> {
    return self.locale.getAnime(withId: id)
      .map { AnimeMapper.mapAnimeEntityToDomain(input: $0) }
      .eraseToAnyPublisher()
  }

  func searchAnime(name: String) -> AnyPublisher<[AnimeModel], Error> {
    return self.remote.searchAnime(name: name)
      .map { AnimeListMapper.mapAnimeListResponsesToEntities(input: $0) }
      .flatMap { self.locale.addAnimes(from: $0) }
      .filter { $0 }
      .flatMap { _ in self.remote.searchAnime(name: name)
          .map { AnimeListMapper.mapAnimeListResponsesToEntities(input: $0) }
          .map { AnimeMapper.mapAnimeEntitiesToDomains(input: $0) }
      }
      .eraseToAnyPublisher()
  }

  func updateAnimeFavorite(withId id: Int) -> AnyPublisher<AnimeModel, Error> {
    return self.locale.updateAnimeFavorite(withId: id)
      .map { AnimeMapper.mapAnimeEntityToDomain(input: $0) }
      .eraseToAnyPublisher()
  }

}
