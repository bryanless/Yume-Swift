//
//  FavoritePresenter.swift
//  Yume
//
//  Created by Bryan on 29/12/22.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []

  private let router = SearchRouter()
  private let favoriteUseCase: FavoriteUseCase

  @Published var favoriteAnimes: [AnimeModel] = []
  @Published var errorMessage: String = ""
  @Published var viewState: FavoriteViewState = .unknown

  init(favoriteUseCase: FavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }

  func getFavoriteAnimes() {
    viewState = .loading
    favoriteUseCase.getFavoriteAnimes()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print(self.errorMessage)
        case .finished:
          self.viewState = .none
        }
      }, receiveValue: { animes in
        self.favoriteAnimes = animes
      })
      .store(in: &cancellables)
  }

  func linkBuilder<Content: View>(
    for anime: AnimeModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
    destination: router.makeAnimeDetailView(for: anime)) { content() }
  }

  enum FavoriteViewState {
    /// Init state
    case unknown
    /// Loading state
    case loading
    /// Completed state
    case none
  }

}
