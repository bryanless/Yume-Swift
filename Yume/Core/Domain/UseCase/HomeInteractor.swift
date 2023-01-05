//
//  HomeInteractor.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation
import Combine

protocol HomeUseCase {

  func getTopAllAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error>
  func getTopAiringAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error>
  func getTopUpcomingAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error>
  func getPopularAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error>

}

class HomeInteractor: HomeUseCase {

  private let repository: AnimeRepositoryProtocol

  required init(repository: AnimeRepositoryProtocol) {
    self.repository = repository
  }

  func getTopAllAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error> {
    return repository.getTopAllAnimes(request: request)
  }

  func getTopAiringAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error> {
    return repository.getTopAiringAnimes(request: request)
  }

  func getTopUpcomingAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error> {
    return repository.getTopUpcomingAnimes(request: request)
  }

  func getPopularAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error> {
    return repository.getPopularAnimes(request: request)
  }

}
