//
//  AnimeDetailInteractor.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation
import Combine

protocol AnimeDetailUseCase {

  func getAnime() -> AnimeModel
  func refreshAnime() -> AnyPublisher<AnimeModel, Error>
  func updateAnimeFavorite(withId id: Int) -> AnyPublisher<AnimeModel, Error>

}

class AnimeDetailInteractor: AnimeDetailUseCase {

  private let repository: AnimeRepositoryProtocol
  private let anime: AnimeModel

  required init(
    repository: AnimeRepositoryProtocol,
    anime: AnimeModel
  ) {
    self.repository = repository
    self.anime = anime
  }

  func getAnime() -> AnimeModel {
    return anime
  }

  func refreshAnime() -> AnyPublisher<AnimeModel, Error> {
    return repository.getAnime(withId: anime.id)
  }

  func updateAnimeFavorite(withId id: Int) -> AnyPublisher<AnimeModel, Error> {
    return repository.updateAnimeFavorite(withId: id)
  }

}
