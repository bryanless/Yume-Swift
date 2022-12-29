//
//  AnimeDetailView.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct AnimeDetailView: View {
  @ObservedObject var presenter: AnimeDetailPresenter

  var body: some View {
    ZStack {
      if presenter.loadingState {
        VStack {
          ProgressView()
          Text("Loading")
        }
      } else {
        ScrollView(.vertical, showsIndicators: false) {
          VStack(spacing: Space.large) {
            overview
            stats
          }.padding(Space.medium)
            .toolbar {
              Button {
                self.presenter.updateAnimeFavorite()
              } label: {
                IconView(
                  icon: self.presenter.anime.isFavorite ? Icons.heart : Icons.heartOutlined,
                  color: .red
                )
              }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
          self.presenter.refreshAnime()
        }
      }
    }
  }
}

extension AnimeDetailView {
  var overview: some View {
    HStack(alignment: .top, spacing: Space.small) {
      mainPicture
      overviewDescription
      Spacer()
    }
  }

  var mainPicture: some View {
    WebImage(url: URL(string: self.presenter.anime.mainPicture))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFill()
      .frame(width: 120, height: 180)
      .cornerRadius(Shape.rounded)
  }

  var overviewDescription: some View {
    VStack(alignment: .leading) {
      Text("\(self.presenter.anime.mediaType)"
           + " · \(self.presenter.anime.startSeason) \(self.presenter.anime.startSeasonYear)"
           + " · \(self.presenter.anime.status)"
      ).typography(.caption())

      Text(self.presenter.anime.title)
        .typography(.title3())
        .bold()
        .lineLimit(3)

      Text(self.presenter.anime.source)
        .typography(.caption2())

      Spacer()

      Text(self.presenter.anime.genre.joined(separator: " · "))
        .typography(.caption())
    }
  }

  var stats: some View {
    HStack(spacing: Space.small) {
      VStack(spacing: Space.tiny) {
        IconView(
          icon: Icons.starOutlined,
          color: .yellow
        )
        Text(self.presenter.anime.rating.description)
      }.frame(width: 60.0)
      VStack(spacing: Space.tiny) {
        IconView(
          icon: Icons.crownOutlined,
          color: .orange
        )
        Text("#\(Formatter.formatNumber(self.presenter.anime.rank))")
      }.frame(width: 60.0)
      VStack(spacing: Space.tiny) {
        IconView(
          icon: Icons.trendingUp,
          color: .green
        )
        Text("#\(Formatter.formatNumber(self.presenter.anime.popularity))")
      }.frame(width: 60.0)
      VStack(spacing: Space.tiny) {
        IconView(
          icon: Icons.usersOutlined,
          color: .purple
        )
        Text(Formatter.formatNumber(self.presenter.anime.userAmount))
      }.frame(width: 60.0)
      VStack(spacing: Space.tiny) {
        IconView(
          icon: Icons.heartOutlined,
          color: .red
        )
        Text(Formatter.formatNumber(self.presenter.anime.userAmount))
      }.frame(width: 60.0)
    }
  }

}
