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
  @State var scrollOffset = CGFloat.zero

  var body: some View {
    ZStack {
      if presenter.loadingState {
        ProgressIndicator()
      } else {
        ZStack(alignment: .top) {
          ObservableScrollView(scrollOffset: $scrollOffset) { _ in
            VStack(spacing: Space.large) {
              overview
              stats
              YumeDivider()
              synopsis
              YumeDivider()
              information
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
          .background(YumeColor.background)
          .onAppear {
            self.presenter.refreshAnime()
          }
          appBar(scrollOffset: scrollOffset)
        }
      }
    }.toolbar(.hidden)
  }
}

extension AnimeDetailView {
  func appBar(scrollOffset: CGFloat) -> some View {
    return GeometryReader { geo in
      ZStack {
          HStack {
            Text(self.presenter.anime.title)
              .typography(.title3(weight: .bold, color: .black))
              .lineLimit(1)
          }
          .padding(
            EdgeInsets(
              top: Space.none,
              leading: Space.medium,
              bottom: Space.small,
              trailing: Space.medium)
          )
          .frame(width: geo.size.width)
        }
      .background(Material.thinMaterial)
      .opacity(scrollOffset / 10)
    }
  }

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
      ).typography(.caption(color: YumeColor.onSurfaceVariant))

      Text(self.presenter.anime.title)
        .typography(.title3(color: YumeColor.onBackground))
        .bold()
        .lineLimit(3)

      Text(self.presenter.anime.source)
        .typography(.caption2(color: YumeColor.onSurfaceVariant))

      Spacer()

      Text(self.presenter.anime.genre.joined(separator: " · "))
        .typography(.caption(color: YumeColor.onSurfaceVariant))
    }
  }

  var stats: some View {
    HStack(spacing: Space.small) {
      AnimeStatItem(
        icon: Icons.starOutlined,
        iconColor: .yellow,
        label: "Score",
        value: self.presenter.anime.rating.description
      )
      AnimeStatItem(
        icon: Icons.crownOutlined,
        iconColor: .orange,
        label: "Rank",
        value: "#\(Formatter.formatNumber(self.presenter.anime.rank))"
      )
      AnimeStatItem(
        icon: Icons.trendingUp,
        iconColor: .green,
        label: "Popularity",
        value: "#\(Formatter.formatNumber(self.presenter.anime.popularity))"
      )
      AnimeStatItem(
        icon: Icons.usersOutlined,
        iconColor: .purple,
        label: "Members",
        value: Formatter.formatNumber(self.presenter.anime.userAmount)
      )
      AnimeStatItem(
        icon: Icons.heartOutlined,
        iconColor: .red,
        label: "Favorites",
        value: Formatter.formatNumber(self.presenter.anime.userAmount)
      )
    }.frame(height: 70)
  }

  var synopsis: some View {
    HStack {
      VStack(alignment: .leading, spacing: Space.small) {
        Text("Synopsis")
          .typography(.headline(color: YumeColor.onBackground))
        Text(self.presenter.anime.synopsis)
          .typography(.body(color: YumeColor.onBackground))
      }
      Spacer()
    }
  }

  var information: some View {
    HStack {
      VStack(alignment: .leading, spacing: Space.small) {
        Text("Information")
          .typography(.headline(color: YumeColor.onBackground))
        AnimeInformationItem(
          label: "Episodes",
          value: self.presenter.anime.episodeAmount.description
        )
        AnimeInformationItem(
          label: "Duration",
          value: self.presenter.anime.episodeDuration.description
        )
        AnimeInformationItem(
          label: "Aired",
          value: "\(self.presenter.anime.startDate) - \(self.presenter.anime.endDate)"
        )
        AnimeInformationItem(
          label: "Studios",
          value: self.presenter.anime.studios.joined(separator: ", ")
        )
      }
      Spacer()
    }
  }

}
