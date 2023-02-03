//
//  SearchPresenter.swift
//  
//
//  Created by Bryan on 08/01/23.
//

import Anime
import Combine
import Core
import Foundation

public class SearchPresenter<
  SearchAnimeUseCase: UseCase,
  TopFavoriteAnimeUseCase: UseCase>: ObservableObject
where SearchAnimeUseCase.Request == AnimeListRequest,
      SearchAnimeUseCase.Response == [AnimeDomainModel],
      TopFavoriteAnimeUseCase.Request == AnimeRankingRequest,
      TopFavoriteAnimeUseCase.Response == [AnimeDomainModel] {
  private var cancellables: Set<AnyCancellable> = []

  private let _searchAnimeUseCase: SearchAnimeUseCase
  private let _topFavoriteAnimeUseCase: TopFavoriteAnimeUseCase

  @Published public var searchText: String = ""
  @Published public var searchAnimeList: [AnimeDomainModel] = []
  @Published public var topFavoriteAnimeList: [AnimeDomainModel] = []
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isRefreshing: Bool = false
  @Published public var isError: Bool = false

  public init(
    searchAnimeUseCase: SearchAnimeUseCase,
    topFavoriteAnimeUseCase: TopFavoriteAnimeUseCase
  ) {
    _searchAnimeUseCase = searchAnimeUseCase
    _topFavoriteAnimeUseCase = topFavoriteAnimeUseCase
    self.doSearchAnime()
  }

  private func doSearchAnime() {
    $searchText
      .debounce(for: 0.5, scheduler: RunLoop.main)
      .removeDuplicates()
      .sink(receiveValue: { [weak self] searchText in
        // API will only search with 3 characters or more
        if searchText.count > 2 {
          self?.searchAnime(title: searchText.trimmingCharacters(in: .whitespacesAndNewlines))
        } else {
          self?.searchAnimeList = []

          // Hide no internet view
          if self?.errorMessage == URLError.notConnectedToInternet.localizedDescription {
            self?.isError = false
          }
        }
      })
      .store(in: &cancellables)
  }

  private func searchAnime(title: String) {
    isLoading = true
    searchAnimeList = []
    _searchAnimeUseCase.execute(request: AnimeListRequest(title: title))
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { animes in
        self.searchAnimeList = animes
      })
      .store(in: &cancellables)
  }

  func getTopFavoriteAnimes() {
    isLoading = true
    _topFavoriteAnimeUseCase.execute(
      request: AnimeRankingRequest(
        type: .favorite,
        refresh: true
      )
    )
    .receive(on: RunLoop.main)
    .sink(receiveCompletion: { completion in
      switch completion {
      case .failure(let error):
        self.errorMessage = error.localizedDescription
        self.isError = true
        self.isLoading = false
      case .finished:
        self.isLoading = false
      }
    }, receiveValue: { animes in
      self.topFavoriteAnimeList = animes
    })
    .store(in: &cancellables)
  }

  func refreshSearchView() {
    if !searchAnimeList.isEmpty {
      refreshSearchAnime()
    } else {
      refreshTopFavoriteAnimes()
    }
  }

  private func refreshSearchAnime() {
    isRefreshing = true
    _searchAnimeUseCase.execute(
      request: AnimeListRequest(title: searchText.trimmingCharacters(in: .whitespacesAndNewlines))
    )
    .receive(on: RunLoop.main)
    .sink(receiveCompletion: { completion in
      switch completion {
      case .failure(let error):
        self.errorMessage = error.localizedDescription
        self.isError = true
        self.isRefreshing = false
      case .finished:
        self.isRefreshing = false
      }
    }, receiveValue: { animes in
      self.searchAnimeList = animes
    })
    .store(in: &cancellables)
  }

  private func refreshTopFavoriteAnimes() {
    isRefreshing = true
    _topFavoriteAnimeUseCase.execute(
      request: AnimeRankingRequest(
        type: .favorite,
        refresh: true
      )
    )
    .receive(on: RunLoop.main)
    .sink(receiveCompletion: { completion in
      switch completion {
      case .failure(let error):
        self.errorMessage = error.localizedDescription
        self.isError = true
        self.isRefreshing = false
      case .finished:
        self.isRefreshing = false
      }
    }, receiveValue: { animes in
      self.topFavoriteAnimeList = animes
    })
    .store(in: &cancellables)
  }

  func retryConnection() {
    if NetworkMonitor.shared.isConnected {
      searchAnime(title: searchText.trimmingCharacters(in: .whitespacesAndNewlines))
      isError = false
    }
  }
}
