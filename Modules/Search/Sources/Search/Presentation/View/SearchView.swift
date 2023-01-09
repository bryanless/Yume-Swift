//
//  SearchView.swift
//  
//
//  Created by Bryan on 08/01/23.
//

//
//  SearchView.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Anime
import Common
import Core
import SwiftUI

public struct SearchView<DetailDestination: View>: View {
  @ObservedObject var presenter: SearchPresenter<
    Interactor<
      AnimeListModuleRequest,
      [AnimeDomainModel],
      SearchAnimeRepository<
        GetAnimeListRemoteDataSource,
        AnimesTransformer>>,
    Interactor<
      AnimeRankingModuleRequest,
      [AnimeDomainModel],
      GetAnimeRankingRepository<
        GetAnimeRankingLocaleDataSource,
        GetAnimeRankingRemoteDataSource,
        AnimesTransformer>>>
  @State var scrollOffset: CGFloat
  let detailDestination: ((_ anime: AnimeDomainModel) -> DetailDestination)

  public init(
    presenter: SearchPresenter<
    Interactor<AnimeListModuleRequest,
    [AnimeDomainModel],
    SearchAnimeRepository<
    GetAnimeListRemoteDataSource,
    AnimesTransformer>>,
    Interactor<
    AnimeRankingModuleRequest,
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
        ProgressIndicator(label: presenter.topFavoriteAnimeList.isEmpty ? "Loading" : "Searching anime")
          .background(YumeColor.background)
      } else if presenter.isError {
        Text(presenter.errorMessage)
          .background(YumeColor.background)
      } else {
        content
      }

      appBar(
        scrollOffset: scrollOffset,
        placeholder: "Search anime",
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
      ObservableScrollView(scrollOffset: $scrollOffset, showsIndicators: false) { _ in
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
