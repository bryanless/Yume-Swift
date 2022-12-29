//
//  FavoriteInteractor.swift
//  Yume
//
//  Created by Bryan on 29/12/22.
//

import Foundation
import Combine

protocol FavoriteUseCase {

  func getFavoriteAnimes() -> AnyPublisher<[AnimeModel], Error>

}

class FavoriteInteractor: FavoriteUseCase {

  private let repository: AnimeRepositoryProtocol

  required init(repository: AnimeRepositoryProtocol) {
    self.repository = repository
  }

  func getFavoriteAnimes() -> AnyPublisher<[AnimeModel], Error> {
    return repository.getFavoriteAnimes()
  }

}
