//
//  AnimeDetailPresenter.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation
import Combine

class AnimeDetailPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []

  private let animeDetailUseCase: AnimeDetailUseCase

  @Published var anime: AnimeModel
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(animeDetailUseCase: AnimeDetailUseCase) {
    self.animeDetailUseCase = animeDetailUseCase
    anime = animeDetailUseCase.getAnime()
  }

  func refreshAnime() {
    animeDetailUseCase.refreshAnime()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print(self.errorMessage)
        case .finished:
          ()
        }
      }, receiveValue: { anime in
        self.anime = anime
      })
      .store(in: &cancellables)
  }

  func updateAnimeFavorite() {
    animeDetailUseCase.updateAnimeFavorite(withId: anime.id, isFavorite: !anime.isFavorite)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print(self.errorMessage)
        case .finished:
          ()
        }
      }, receiveValue: { anime in
        self.anime = anime
      })
      .store(in: &cancellables)
  }

}
