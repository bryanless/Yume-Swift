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
where TopAiringAnimeUseCase.Request == AnimeRankingModuleRequest,
      TopAiringAnimeUseCase.Response == [AnimeDomainModel],
      TopUpcomingAnimeUseCase.Request == AnimeRankingModuleRequest,
      TopUpcomingAnimeUseCase.Response == [AnimeDomainModel],
      PopularAnimeUseCase.Request == AnimeRankingModuleRequest,
      PopularAnimeUseCase.Response == [AnimeDomainModel],
      TopAllAnimeUseCase.Request == AnimeRankingModuleRequest,
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
  @Published public var isError: Bool = false

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
    let topAiringAnimePublisher = _topAiringAnimeUseCase.execute(request: AnimeRankingModuleRequest(type: "airing"))
    getTopAiringAnimes(publisher: topAiringAnimePublisher)

    // Get top upcoming anime
    let topUpcomingAnimePublisher = _topUpcomingAnimeUseCase.execute(
      request: AnimeRankingModuleRequest(type: "upcoming"))
    getTopUpcomingAnimes(publisher: topUpcomingAnimePublisher)

    // Get popular anime
    let popularAnimePublisher = _popularAnimeUseCase.execute(request: AnimeRankingModuleRequest(type: "bypopularity"))
    getPopularAnimes(publisher: popularAnimePublisher)

    // Get top anime series
    let topAllAnimePublisher = _topAllAnimeUseCase.execute(request: AnimeRankingModuleRequest(type: "all"))
    getTopAllAnimes(publisher: topAllAnimePublisher)

    let loadingPublishers = Publishers.CombineLatest4(
      topAiringAnimePublisher,
      topUpcomingAnimePublisher,
      popularAnimePublisher,
      topAllAnimePublisher
    ).map { topAiringAnimes, topUpcomingAnimes, popularAnimes, topAllAnimes in
      topAiringAnimes.isEmpty || topUpcomingAnimes.isEmpty || popularAnimes.isEmpty || topAllAnimes.isEmpty
    }

    loadingPublishers.sink(receiveCompletion: { completion in
      switch completion {
      case .failure:
        self.errorMessage = String(describing: completion)
        print(self.errorMessage)
      case .finished:
        ()
      }
    }, receiveValue: { isLoading in
      self.isLoading = isLoading
    }).store(in: &cancellables)
  }

  private func getTopAiringAnimes(publisher: AnyPublisher<[AnimeDomainModel], Error>) {
    publisher
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print(self.errorMessage)
        case .finished:
          ()
        }
      }, receiveValue: { animes in
        self.topAiringAnimeList = animes
      })
      .store(in: &cancellables)
  }

  private func getTopUpcomingAnimes(publisher: AnyPublisher<[AnimeDomainModel], Error>) {
    publisher
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print(self.errorMessage)
        case .finished:
          ()
        }
      }, receiveValue: { animes in
        self.topUpcomingAnimeList = animes
      })
      .store(in: &cancellables)
  }

  private func getPopularAnimes(publisher: AnyPublisher<[AnimeDomainModel], Error>) {
    publisher
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print(self.errorMessage)
        case .finished:
          ()
        }
      }, receiveValue: { animes in
        self.popularAnimeList = animes
      })
      .store(in: &cancellables)
  }

  private func getTopAllAnimes(publisher: AnyPublisher<[AnimeDomainModel], Error>) {
    publisher
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print(self.errorMessage)
        case .finished:
          ()
        }
      }, receiveValue: { animes in
        self.topAllAnimeList = animes
      })
      .store(in: &cancellables)
  }
}