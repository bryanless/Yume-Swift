//
//  HomePresenter.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []

  private let router = HomeRouter()
  private let homeUseCase: HomeUseCase

  @Published var topAllAnimes: [AnimeModel] = []
  @Published var topAiringAnimes: [AnimeModel] = []
  @Published var topUpcomingAnimes: [AnimeModel] = []
  @Published var popularAnimes: [AnimeModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }

  func setupHomeView() {
    self.loadingState = true

    // MARK: - Get top anime series
    let topAllAnimePublisher = homeUseCase.getTopAllAnimes()
      .receive(on: RunLoop.main)

    topAllAnimePublisher.sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print(self.errorMessage)
        case .finished:
          ()
        }
      }, receiveValue: { animes in
        self.topAllAnimes = animes
      })
      .store(in: &cancellables)

    // MARK: - Get top airing anime
    let topAiringAnimePublisher = homeUseCase.getTopAiringAnimes()
      .receive(on: RunLoop.main)

    topAiringAnimePublisher.sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print(self.errorMessage)
        case .finished:
          ()
        }
      }, receiveValue: { animes in
        self.topAiringAnimes = animes
      })
      .store(in: &cancellables)

    // MARK: - Get top upcoming anime
    let topUpcomingAnimePublisher = homeUseCase.getTopUpcomingAnimes()
      .receive(on: RunLoop.main)

    topUpcomingAnimePublisher.sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print(self.errorMessage)
        case .finished:
          ()
        }
      }, receiveValue: { animes in
        self.topUpcomingAnimes = animes
      })
      .store(in: &cancellables)

    // MARK: - Get popular anime
    let popularAnimePublisher = homeUseCase.getPopularAnimes()
      .receive(on: RunLoop.main)

    popularAnimePublisher.sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print(self.errorMessage)
        case .finished:
          ()
        }
      }, receiveValue: { animes in
        self.popularAnimes = animes
      })
      .store(in: &cancellables)

    let loadingPublishers = Publishers.CombineLatest4(
      topAllAnimePublisher,
      topAiringAnimePublisher,
      topUpcomingAnimePublisher,
      popularAnimePublisher
    ).map { topAllAnimes, topAiringAnimes, topUpcomingAnimes, popularAnimes in
      topAllAnimes.isEmpty || topAiringAnimes.isEmpty || topUpcomingAnimes.isEmpty || popularAnimes.isEmpty
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
      self.loadingState = isLoading
    }).store(in: &cancellables)
  }

  func seeAllLinkBuilder<Content: View>(
    for animes: [AnimeModel],
    navigationTitle title: String,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
    destination: router.makeSeeAllView(for: animes, navigationTitle: title)) { content() }
  }

  func animeDetailLinkBuilder<Content: View>(
    for anime: AnimeModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
    destination: router.makeAnimeDetailView(for: anime)) { content() }
  }

}
