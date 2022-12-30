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
  @Published var searchAnimeResults: [AnimeModel] = []
  @Published var topFavoriteAnimes: [AnimeModel] = []
  @Published var errorMessage: String = ""
  @Published var viewState: SearchViewState = .unknown

  init(searchUseCase: SearchUseCase) {
    self.searchUseCase = searchUseCase
    self.doSearchAnime()
  }

  func doSearchAnime() {
    $searchText
      .removeDuplicates()
      .debounce(for: 0.6, scheduler: RunLoop.main)
      .map { $0.count > 2 }
      .receive(on: RunLoop.main)
      .sink(receiveValue: { [weak self] isValid in
        if isValid {
          self?.searchAnime()
        } else {
          self?.viewState = .none
          self?.searchAnimeResults = []
        }
      })
      .store(in: &cancellables)
  }

  func searchAnime() {
    viewState = .loading
    searchAnimeResults = []
    searchUseCase.searchAnime(name: searchText)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print(self.errorMessage)
        case .finished:
          self.viewState = .completed
        }
      }, receiveValue: { animes in
        self.searchAnimeResults = animes
      })
      .store(in: &cancellables)
  }

  func getTopFavoriteAnimes() {
    searchUseCase.getTopFavoriteAnimes()
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
        self.topFavoriteAnimes = animes
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

  enum SearchViewState {
    /// Init state
    case unknown
    /// Loading state
    case loading
    /// Nothing state
    case none
    /// Completed state
    case completed
  }

}
