//
//  SearchView.swift
//  
//
//  Created by Bryan on 08/01/23.
//

import Anime
import Common
import Core
import SwiftUI

public struct SearchView<DetailDestination: View>: View {
  @ObservedObject var presenter: SearchPresenter<
    Interactor<
      AnimeListRequest,
      [AnimeDomainModel],
      SearchAnimeRepository<
        GetAnimeListLocaleDataSource,
        GetAnimeListRemoteDataSource,
        AnimesTransformer>>,
    Interactor<
      AnimeRankingRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>>>
  @State var scrollOffset: CGFloat
  let detailDestination: ((_ anime: AnimeDomainModel) -> DetailDestination)

  public init(
    presenter: SearchPresenter<
    Interactor<AnimeListRequest,
    [AnimeDomainModel],
    SearchAnimeRepository<
    GetAnimeListLocaleDataSource,
    GetAnimeListRemoteDataSource,
    AnimesTransformer>>,
    Interactor<
    AnimeRankingRequest,
    [AnimeDomainModel], GetAnimeRankingRepository<
    GetAnimeRankingLocaleDataSource,
    GetAnimeRankingRemoteDataSource,
    AnimesTransformer>>>,
    scrollOffset: CGFloat = CGFloat.zero,
    detailDestination: @escaping ((AnimeDomainModel) -> DetailDestination)
  ) {
    self.presenter = presenter
    self.scrollOffset = scrollOffset
    self.detailDestination = detailDestination
  }

  public var body: some View {
    ZStack(alignment: .top) {
      if presenter.isLoading {
        ProgressIndicator(label: presenter.topFavoriteAnimeList.isEmpty
                          ? "loading_label".localized(bundle: .common)
                          : "searching_anime_label".localized(bundle: .module))
        .background(YumeColor.background)
      } else if presenter.isError {
        if presenter.errorMessage == URLError.notConnectedToInternet.localizedDescription {
          NoInternetView(onRetry: presenter.retryConnection)
        } else {
          CustomEmptyView(label: presenter.errorMessage)
        }
      } else {
        content
      }

      appBar(
        scrollOffset: scrollOffset,
        placeholder: "search_placeholder".localized(bundle: .module),
        searchText: self.$presenter.searchText
      )
    }.onAppear {
      if presenter.topFavoriteAnimeList.isEmpty {
        presenter.getTopFavoriteAnimes()
      }
    }
  }
}

extension SearchView {
  var content: some View {
    ZStack {
      RefreshableScrollView(
        scrollOffset: $scrollOffset,
        showsIndicators: false,
        isRefreshing: $presenter.isRefreshing,
        onRefresh: presenter.refreshSearchView
      ) { _ in
        LazyVStack(spacing: Space.small) {
          ForEach(
            presenter.searchAnimeList.isEmpty
            ? Array(presenter.topFavoriteAnimeList.prefix(20)) : presenter.searchAnimeList
          ) { anime in
            NavigationLink(destination: detailDestination(anime)) {
              AnimeCardItem(anime: anime)
            }.buttonStyle(.plain)
          }
        }.padding(Space.medium)
      }
      .padding(.top, 40.0)
      .background(YumeColor.background)
      .scrollDismissesKeyboard(.immediately)
    }
  }

  func appBar(
    scrollOffset: CGFloat,
    placeholder: String,
    searchText: Binding<String>
  ) -> some View {
    return SearchBar(
      placeholder: placeholder,
      searchText: searchText
    )
    .padding(
      EdgeInsets(
        top: Space.none,
        leading: Space.medium,
        bottom: Space.small,
        trailing: Space.medium)
    )
    .background(scrollOffset > 1 ? YumeColor.surface2 : Color.black.opacity(0))
  }
}
