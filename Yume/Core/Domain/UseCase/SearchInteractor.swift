//
//  SearchInteractor.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation
import Combine

protocol SearchUseCase {

  func searchAnime(name: String) -> AnyPublisher<[AnimeModel], Error>
  func getTopFavoriteAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error>

}

class SearchInteractor: SearchUseCase {

  private let repository: AnimeRepositoryProtocol

  required init(repository: AnimeRepositoryProtocol) {
    self.repository = repository
  }

  func searchAnime(name: String) -> AnyPublisher<[AnimeModel], Error> {
    return repository.searchAnime(name: name)
  }

  func getTopFavoriteAnimes(request: AnimeRankingRequest) -> AnyPublisher<[AnimeModel], Error> {
    return repository.getTopFavoriteAnimes(request: request)
  }

}
