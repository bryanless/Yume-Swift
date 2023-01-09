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
  func provideAnimeRanking<U: UseCase>() -> U
  where
  U.Request == AnimeRankingModuleRequest,
  U.Response == [AnimeDomainModel] {
    let locale = GetAnimeRankingLocaleDataSource(realm: AppDelegate.instance.realm)

    let remote = GetAnimeRankingRemoteDataSource(
      endpoint: Endpoints.Gets.ranking.url,
      encoder: API.encoder,
      headers: API.headers
    )

    let mapper = AnimesTransformer()

    let repository = GetAnimeRankingRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideSearchAnime<U: UseCase>() -> U
  where
  U.Request == AnimeListModuleRequest,
  U.Response == [AnimeDomainModel] {
    let remote = GetAnimeListRemoteDataSource(
      endpoint: Endpoints.Gets.search.url,
      encoder: API.encoder,
      headers: API.headers
    )

    let mapper = AnimesTransformer()

    let repository = SearchAnimeRepository(
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideAnime<U: UseCase>() -> U
  where
  U.Request == AnimeRequest,
  U.Response == AnimeDomainModel {
    let locale = GetAnimeLocaleDataSource(realm: AppDelegate.instance.realm)

    let remote = GetAnimeRemoteDataSource(
      endpoint: Endpoints.Gets.detail.url,
      encoder: API.encoder,
      headers: API.headers
    )

    let mapper = AnimeTransformer()

    let repository = GetAnimeRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper
    )

    return Interactor(repository: repository) as! U
  }

  func provideUpdateFavoriteAnime<U: UseCase>() -> U
  where
  U.Request == Int,
  U.Response == AnimeDomainModel {
    let locale = GetFavoriteAnimeLocaleDataSource(realm: AppDelegate.instance.realm)

    let mapper = AnimeDataTransformer()

    let repository = UpdateFavoriteAnimeRepository(
      localeDataSource: locale,
      mapper: mapper
    )

    return Interactor(repository: repository) as! U
  }

  func provideFavoriteAnime<U: UseCase>() -> U
  where
  U.Request == Int,
  U.Response == [AnimeDomainModel] {
    let locale = GetFavoriteAnimeLocaleDataSource(realm: AppDelegate.instance.realm)

    let mapper = AnimesTransformer()

    let repository = GetFavoriteAnimesRepository(
      localeDataSource: locale,
      mapper: mapper
    )

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
