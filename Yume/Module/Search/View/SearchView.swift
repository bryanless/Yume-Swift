//
//  SearchView.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import SwiftUI

struct SearchView: View {
  @ObservedObject var presenter: SearchPresenter
  @State var scrollOffset = CGFloat.zero

  var body: some View {
    ZStack {
      if presenter.viewState == .unknown {
        ProgressIndicator()
          .background(YumeColor.background)
          .onAppear {
            self.presenter.getTopFavoriteAnimes()
          }
      } else {
        ZStack(alignment: .top) {
          if presenter.viewState == .loading {
            ProgressIndicator(label: "Searching anime")
              .background(YumeColor.background)
          } else if presenter.viewState == .completed && presenter.searchAnimeResults.isEmpty {
            NothingFound(label: "No anime found")
              .background(YumeColor.background)
          } else {
            ObservableScrollView(scrollOffset: $scrollOffset, showsIndicators: false) { _ in
              LazyVStack(spacing: Space.small) {
                ForEach(
                  self.presenter.searchAnimeResults.isEmpty
                  ? self.presenter.topFavoriteAnimes : self.presenter.searchAnimeResults
                ) { anime in
                  self.presenter.linkBuilder(for: anime) {
                    AnimeCardItem(anime: anime)
                  }.buttonStyle(.plain)
                }
              }.padding(Space.medium)
            }
            .padding(.top, 40.0)
            .background(YumeColor.background)
          }

          appBar(
            scrollOffset: scrollOffset,
            placeholder: "Search anime",
            searchText: self.$presenter.searchText
          )
        }
      }
    }.onAppear {
      if self.presenter.topFavoriteAnimes.isEmpty {
        self.presenter.getTopFavoriteAnimes()
      }
    }
  }
}

extension SearchView {
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
