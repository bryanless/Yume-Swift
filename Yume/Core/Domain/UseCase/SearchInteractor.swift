//
//  SearchInteractor.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation
import Combine

protocol SearchUseCase {

  func getTopAllAnimes() -> AnyPublisher<[AnimeModel], Error>

}

class SearchInteractor: SearchUseCase {

  private let repository: AnimeRepositoryProtocol

  required init(repository: AnimeRepositoryProtocol) {
    self.repository = repository
  }

  func getTopAllAnimes() -> AnyPublisher<[AnimeModel], Error> {
    return repository.getTopAllAnimes()
  }

}
