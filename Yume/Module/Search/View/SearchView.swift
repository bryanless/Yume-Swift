//
//  SearchView.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import SwiftUI

struct SearchView: View {
  @ObservedObject var presenter: SearchPresenter

  var body: some View {
    ZStack {
      if presenter.loadingState {
        VStack {
          ProgressView()
          Text("Loading")
        }
      } else {
        NavigationStack {
          ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: Space.small) {
              ForEach(self.presenter.topAllAnimes) { anime in
                self.presenter.linkBuilder(for: anime) {
                  AnimeCardItem(anime: anime)
                }.buttonStyle(.plain)
              }
            }.padding(Space.medium)
          }.navigationTitle("Search")
        }.onAppear {
          if self.presenter.topAllAnimes.isEmpty {
            self.presenter.getTopAllAnimes()
          }
        }
      }
    }
  }
}
