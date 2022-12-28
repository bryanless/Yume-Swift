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

  func getPopularAnimes() -> AnyPublisher<[AnimeModel], Error> {
    return repository.getPopularAnimes()
  }

}
