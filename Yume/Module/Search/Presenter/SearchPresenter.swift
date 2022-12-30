//
//  SearchPresenter.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import SwiftUI
import Combine

class SearchPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []

  private let router = SearchRouter()
  private let searchUseCase: SearchUseCase

  @Published var searchText: String = ""
  @Published var topAllAnimes: [AnimeModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(searchUseCase: SearchUseCase) {
    self.searchUseCase = searchUseCase
  }

  func getTopAllAnimes() {
    loadingState = true
    searchUseCase.getTopAllAnimes()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print(self.errorMessage)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { animes in
        self.topAllAnimes = animes
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

}
