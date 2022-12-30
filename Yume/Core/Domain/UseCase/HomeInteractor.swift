//
//  HomeInteractor.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation
import Combine

protocol HomeUseCase {

  func getTopAllAnimes() -> AnyPublisher<[AnimeModel], Error>
  func getTopAiringAnimes() -> AnyPublisher<[AnimeModel], Error>
  func getTopUpcomingAnimes() -> AnyPublisher<[AnimeModel], Error>
  func getPopularAnimes() -> AnyPublisher<[AnimeModel], Error>

}

class HomeInteractor: HomeUseCase {

  private let repository: AnimeRepositoryProtocol

  required init(repository: AnimeRepositoryProtocol) {
    self.repository = repository
  }

  func getTopAllAnimes() -> AnyPublisher<[AnimeModel], Error> {
    return repository.getTopAllAnimes()
  }

  func getTopAiringAnimes() -> AnyPublisher<[AnimeModel], Error> {
    return repository.getTopAiringAnimes()
  }

  func getTopUpcomingAnimes() -> AnyPublisher<[AnimeModel], Error> {
    return repository.getTopUpcomingAnimes()
  }

  func getPopularAnimes() -> AnyPublisher<[AnimeModel], Error> {
    return repository.getPopularAnimes()
  }

}
