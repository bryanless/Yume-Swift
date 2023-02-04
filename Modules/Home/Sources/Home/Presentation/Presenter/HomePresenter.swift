//
//  HomePresenter.swift
//  
//
//  Created by Bryan on 07/01/23.
//

import Anime
import Combine
import Core
import Foundation

public class HomePresenter<
  TopAiringAnimeUseCase: UseCase,
  TopUpcomingAnimeUseCase: UseCase,
  PopularAnimeUseCase: UseCase,
  TopAllAnimeUseCase: UseCase>: ObservableObject
where TopAiringAnimeUseCase.Request == AnimeRankingRequest,
      TopAiringAnimeUseCase.Response == [AnimeDomainModel],
      TopUpcomingAnimeUseCase.Request == AnimeRankingRequest,
      TopUpcomingAnimeUseCase.Response == [AnimeDomainModel],
      PopularAnimeUseCase.Request == AnimeRankingRequest,
      PopularAnimeUseCase.Response == [AnimeDomainModel],
      TopAllAnimeUseCase.Request == AnimeRankingRequest,
      TopAllAnimeUseCase.Response == [AnimeDomainModel] {
  private var cancellables: Set<AnyCancellable> = []

  private let _topAiringAnimeUseCase: TopAiringAnimeUseCase
  private let _topUpcomingAnimeUseCase: TopUpcomingAnimeUseCase
  private let _popularAnimeUseCase: PopularAnimeUseCase
  private let _topAllAnimeUseCase: TopAllAnimeUseCase

  @Published public var topAiringAnimeList: [AnimeDomainModel] = []
  @Published public var topUpcomingAnimeList: [AnimeDomainModel] = []
  @Published public var popularAnimeList: [AnimeDomainModel] = []
  @Published public var topAllAnimeList: [AnimeDomainModel] = []
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isRefreshing: Bool = false
  @Published public var isError: Bool = false
  @Published public var showSnackbar: Bool = false

  public init(
    topAiringAnimeUseCase: TopAiringAnimeUseCase,
    topUpcomingAnimeUseCase: TopUpcomingAnimeUseCase,
    popularAnimeUseCase: PopularAnimeUseCase,
    topAllAnimeUseCase: TopAllAnimeUseCase
  ) {
    _topAiringAnimeUseCase = topAiringAnimeUseCase
    _topUpcomingAnimeUseCase = topUpcomingAnimeUseCase
    _popularAnimeUseCase = popularAnimeUseCase
    _topAllAnimeUseCase = topAllAnimeUseCase
  }

  public func setupHomeView() {
    isLoading = true

    // Get top airing anime
    let topAiringAnimePublisher = _topAiringAnimeUseCase.execute(
      request: AnimeRankingRequest(type: .airing, refresh: true))

    // Get top upcoming anime
    let topUpcomingAnimePublisher = _topUpcomingAnimeUseCase.execute(
      request: AnimeRankingRequest(type: .upcoming, refresh: true))

    // Get popular anime
    let popularAnimePublisher = _popularAnimeUseCase.execute(
      request: AnimeRankingRequest(type: .byPopularity, refresh: true))

    // Get top anime series
    let topAllAnimePublisher = _topAllAnimeUseCase.execute(
      request: AnimeRankingRequest(type: .all, refresh: true))

    let loadingPublishers = Publishers.CombineLatest4(
      topAiringAnimePublisher,
      topUpcomingAnimePublisher,
      popularAnimePublisher,
      topAllAnimePublisher
    )

    loadingPublishers
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
        self.topAiringAnimeList = animes.0
        self.topUpcomingAnimeList = animes.1
        self.popularAnimeList = animes.2
        self.topAllAnimeList = animes.3
      })
      .store(in: &cancellables)
  }

  public func refreshHomeView() {
    isRefreshing = true

    // Get top airing anime
    let topAiringAnimePublisher = _topAiringAnimeUseCase.execute(
      request: AnimeRankingRequest(type: .airing, refresh: true))

    // Get top upcoming anime
    let topUpcomingAnimePublisher = _topUpcomingAnimeUseCase.execute(
      request: AnimeRankingRequest(type: .upcoming, refresh: true))

    // Get popular anime
    let popularAnimePublisher = _popularAnimeUseCase.execute(
      request: AnimeRankingRequest(type: .byPopularity, refresh: true))

    // Get top anime series
    let topAllAnimePublisher = _topAllAnimeUseCase.execute(
      request: AnimeRankingRequest(type: .all, refresh: true))

    let loadingPublishers = Publishers.CombineLatest4(
      topAiringAnimePublisher,
      topUpcomingAnimePublisher,
      popularAnimePublisher,
      topAllAnimePublisher
    )

    loadingPublishers
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.showSnackbar = true
          self.isRefreshing = false
        case .finished:
          self.isRefreshing = false

          if !NetworkMonitor.shared.isConnected {
            self.errorMessage = URLError.notConnectedToInternet.localizedDescription
            self.showSnackbar = true
          }
        }
      }, receiveValue: { animes in
        self.topAiringAnimeList = animes.0
        self.topUpcomingAnimeList = animes.1
        self.popularAnimeList = animes.2
        self.topAllAnimeList = animes.3
      })
      .store(in: &cancellables)
  }

  func retryConnection() {
    if NetworkMonitor.shared.isConnected {
      setupHomeView()
      isError = false
    }
  }
}
