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
    loadingState = true

    // Get top airing anime
    let topAiringAnimePublisher = homeUseCase.getTopAiringAnimes()
    getTopAiringAnimes(publisher: topAiringAnimePublisher)

    // Get top upcoming anime
    let topUpcomingAnimePublisher = homeUseCase.getTopUpcomingAnimes()
    getTopUpcomingAnimes(publisher: topUpcomingAnimePublisher)

    // Get popular anime
    let popularAnimePublisher = homeUseCase.getPopularAnimes()
    getPopularAnimes(publisher: popularAnimePublisher)

    // Get top anime series
    let topAllAnimePublisher = homeUseCase.getTopAllAnimes()
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
      self.loadingState = isLoading
    }).store(in: &cancellables)
  }

  private func getTopAiringAnimes(publisher: AnyPublisher<[AnimeModel], Error>) {
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
        self.topAiringAnimes = animes
      })
      .store(in: &cancellables)
  }

  private func getTopUpcomingAnimes(publisher: AnyPublisher<[AnimeModel], Error>) {
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
        self.topUpcomingAnimes = animes
      })
      .store(in: &cancellables)
  }

  private func getPopularAnimes(publisher: AnyPublisher<[AnimeModel], Error>) {
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
        self.popularAnimes = animes
      })
      .store(in: &cancellables)
  }

  private func getTopAllAnimes(publisher: AnyPublisher<[AnimeModel], Error>) {
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
        self.topAllAnimes = animes
      })
      .store(in: &cancellables)
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
