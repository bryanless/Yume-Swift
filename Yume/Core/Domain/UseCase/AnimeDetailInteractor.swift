//
//  AnimeDetailInteractor.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation

protocol AnimeDetailUseCase {

  func getAnime() -> AnimeModel

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

}
