//
//  SeeAllView.swift
//  Yume
//
//  Created by Bryan on 29/12/22.
//

import SwiftUI

struct SeeAllView: View {
  @ObservedObject var presenter: SeeAllPresenter

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
              ForEach(self.presenter.animes) { anime in
                self.presenter.linkBuilder(for: anime) {
                  AnimeCardItem(anime: anime)
                }.buttonStyle(.plain)
              }
            }.padding(Space.medium)
          }.background(YumeColor.background)
        }
      }
    }.toolbar(.hidden)
  }
}
