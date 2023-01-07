//
//  Injection.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Anime
import Core

import Foundation
import RealmSwift

final class Injection: NSObject {
  func provideTopAllAnime<U: UseCase>() -> U
  where
  U.Request == AnimeRankingModuleRequest,
  U.Response == [AnimeDomainModel] {
    let locale = GetTopAllAnimesLocaleDataSource(realm: AppDelegate.instance.realm)

    let remote = GetAnimeRankingRemoteDataSource(
      endpoint: Endpoints.Gets.ranking.url,
      encoder: API.encoder,
      headers: API.headers
    )

    let mapper = AnimeTransformer()

    let repository = GetAnimesRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideTopAiringAnime<U: UseCase>() -> U
  where
  U.Request == AnimeRankingModuleRequest,
  U.Response == [AnimeDomainModel] {
    let locale = GetTopAiringAnimesLocaleDataSource(realm: AppDelegate.instance.realm)

    let remote = GetAnimeRankingRemoteDataSource(
      endpoint: Endpoints.Gets.ranking.url,
      encoder: API.encoder,
      headers: API.headers
    )

    let mapper = AnimeTransformer()

    let repository = GetAnimesRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideTopUpcomingAnime<U: UseCase>() -> U
  where
  U.Request == AnimeRankingModuleRequest,
  U.Response == [AnimeDomainModel] {
    let locale = GetTopUpcomingAnimesLocaleDataSource(realm: AppDelegate.instance.realm)

    let remote = GetAnimeRankingRemoteDataSource(
      endpoint: Endpoints.Gets.ranking.url,
      encoder: API.encoder,
      headers: API.headers
    )

    let mapper = AnimeTransformer()

    let repository = GetAnimesRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func providePopularAnime<U: UseCase>() -> U
  where
  U.Request == AnimeRankingModuleRequest,
  U.Response == [AnimeDomainModel] {
    let locale = GetPopularAnimesLocaleDataSource(realm: AppDelegate.instance.realm)

    let remote = GetAnimeRankingRemoteDataSource(
      endpoint: Endpoints.Gets.ranking.url,
      encoder: API.encoder,
      headers: API.headers
    )

    let mapper = AnimeTransformer()

    let repository = GetAnimesRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideTopFavoriteAnime<U: UseCase>() -> U
  where
  U.Request == AnimeRankingModuleRequest,
  U.Response == [AnimeDomainModel] {
    let locale = GetTopFavoriteAnimesLocaleDataSource(realm: AppDelegate.instance.realm)

    let remote = GetAnimeRankingRemoteDataSource(
      endpoint: Endpoints.Gets.ranking.url,
      encoder: API.encoder,
      headers: API.headers
    )

    let mapper = AnimeTransformer()

    let repository = GetAnimesRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  private func provideRepository() -> AnimeRepositoryProtocol {
    let realm = try? Realm()

    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance

    return AnimeRepository.sharedInstance(locale, remote)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }

  func provideSeeAll(navigationTitle: String, animes: [AnimeModel]) -> SeeAllUseCase {
    let repository = provideRepository()
    return SeeAllInteractor(repository: repository, navigationTitle: navigationTitle, animes: animes)
  }

  func provideSearch() -> SearchUseCase {
    let repository = provideRepository()
    return SearchInteractor(repository: repository)
  }

  func provideAnimeDetail(anime: AnimeModel) -> AnimeDetailUseCase {
    let repository = provideRepository()
    return AnimeDetailInteractor(repository: repository, anime: anime)
  }

  func provideFavorite() -> FavoriteUseCase {
    let repository = provideRepository()
    return FavoriteInteractor(repository: repository)
  }

}
