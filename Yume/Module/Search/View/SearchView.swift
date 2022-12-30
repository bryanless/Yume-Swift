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
      if presenter.loadingState {
        VStack {
          ProgressView()
          Text("Loading")
        }
      } else {
        NavigationStack {
          ZStack(alignment: .top) {
            ObservableScrollView(scrollOffset: $scrollOffset) { _ in
              LazyVStack(spacing: Space.small) {
                ForEach(self.presenter.topAllAnimes) { anime in
                  self.presenter.linkBuilder(for: anime) {
                    AnimeCardItem(anime: anime)
                  }.buttonStyle(.plain)
                }
              }.padding(Space.medium)
            }.padding(.top, 40.0)
            appBar(
              scrollOffset: scrollOffset,
              placeholder: "Search anime",
              searchText: self.$presenter.searchText
            )
          }
          .background(YumeColor.background)

        }.onAppear {
          if self.presenter.topAllAnimes.isEmpty {
            self.presenter.getTopAllAnimes()
          }
        }
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
    .background(YumeColor.background)
  }
}
