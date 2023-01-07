//
//  AnimeDetailView.swift
//  
//
//  Created by Bryan on 07/01/23.
//

import Anime
import Common
import Core
import SDWebImageSwiftUI
import SwiftUI

public struct AnimeDetailView: View {
  @ObservedObject var presenter: AnimePresenter<
    Interactor<
      Int,
      AnimeDomainModel,
      GetAnimeRepository<
        GetAnimeLocaleDataSource,
        AnimeTransformer>>,
    Interactor<
      Int,
      AnimeDomainModel,
      UpdateFavoriteAnimeRepository<
        GetFavoriteAnimeLocaleDataSource,
        AnimeTransformer>>>
  @State var scrollOffset: CGFloat

  let anime: AnimeDomainModel

  public init(
    presenter: AnimePresenter<
    Interactor<
    Int,
    AnimeDomainModel,
    GetAnimeRepository<
    GetAnimeLocaleDataSource,
    AnimeTransformer>>,
    Interactor<
    Int,
    AnimeDomainModel,
    UpdateFavoriteAnimeRepository<
    GetFavoriteAnimeLocaleDataSource,
    AnimeTransformer>>>,
    scrollOffset: CGFloat = CGFloat.zero, anime: AnimeDomainModel
  ) {
    self.presenter = presenter
    self.scrollOffset = scrollOffset
    self.anime = anime
  }

  public var body: some View {
    ZStack {
      if presenter.isLoading {
        ProgressIndicator()
          .background(YumeColor.background)
      } else if presenter.isError {
        Text(presenter.errorMessage)
          .background(YumeColor.background)
      } else {
        content
      }
    }
    .toolbar(.hidden)
    .onAppear {
      presenter.getAnime(request: anime.id)
    }
  }
}

extension AnimeDetailView {
  var content: some View {
    ZStack(alignment: .top) {
      ObservableScrollView(scrollOffset: $scrollOffset, showsIndicators: false) { _ in
        VStack(spacing: Space.large) {
          overview
          stats
          YumeDivider()
          synopsis
          YumeDivider()
          information
        }.padding(
          EdgeInsets(
            top: 40,
            leading: Space.medium,
            bottom: Space.medium,
            trailing: Space.medium)
        )
      }

      BackAppBar(scrollOffset: scrollOffset, label: "", trailing: {
        Button {
          presenter.updateFavoriteAnime(request: anime.id)
        } label: {
          IconView(
            icon: presenter.item?.isFavorite ?? false ? Icons.heart : Icons.heartOutlined,
            color: presenter.item?.isFavorite ?? false ? .red : YumeColor.onSurface
          )
        }
      })
    }.background(YumeColor.background)
  }

  var overview: some View {
    HStack(alignment: .top, spacing: Space.small) {
      mainPicture
      overviewDescription
      Spacer()
    }
  }

  var mainPicture: some View {
    WebImage(url: URL(string: presenter.item?.mainPicture ?? ""))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFill()
      .frame(width: 120, height: 180)
      .cornerRadius(Shape.rounded)
  }

  var overviewDescription: some View {
    VStack(alignment: .leading) {
      Text("\(presenter.item?.mediaType ?? "")"
           + " · \(presenter.item?.startSeason ?? "") \(presenter.item?.startSeasonYear ?? "")"
           + " · \(presenter.item?.status ?? "")"
      ).typography(.caption(color: YumeColor.onSurfaceVariant))

      Text((presenter.item?.alternativeTitleEnglish.isEmpty ?? true
            ? presenter.item?.title : presenter.item?.alternativeTitleEnglish) ?? "")
      .typography(.title3(color: YumeColor.onBackground))
      .bold()
      .lineLimit(3)

      Text(presenter.item?.source ?? "")
        .typography(.caption2(color: YumeColor.onSurfaceVariant))

      Spacer()

      Text(presenter.item?.genre.joined(separator: " · ") ?? "")
        .typography(.caption(color: YumeColor.onSurfaceVariant))
    }
  }

  var stats: some View {
    HStack(spacing: Space.small) {
      AnimeStatItem(
        icon: Icons.starOutlined,
        iconColor: .yellow,
        label: "Score",
        value: presenter.item?.rating.description ?? "0"
      )
      AnimeStatItem(
        icon: Icons.crownOutlined,
        iconColor: .orange,
        label: "Rank",
        value: "#\(presenter.item?.rank.formatNumber() ?? "0")"
      )
      AnimeStatItem(
        icon: Icons.trendingUp,
        iconColor: .green,
        label: "Popularity",
        value: "#\(presenter.item?.popularity.formatNumber() ?? "0")"
      )
      AnimeStatItem(
        icon: Icons.usersOutlined,
        iconColor: .purple,
        label: "Members",
        value: presenter.item?.userAmount.formatNumber() ?? "0"
      )
      AnimeStatItem(
        icon: Icons.heartOutlined,
        iconColor: .red,
        label: "Favorites",
        value: presenter.item?.favoriteAmount.formatNumber() ?? "0"
      )
    }.frame(height: 70)
  }

  var synopsis: some View {
    HStack {
      VStack(alignment: .leading, spacing: Space.small) {
        Text("Synopsis")
          .typography(.headline(color: YumeColor.onBackground))
        Text(presenter.item?.synopsis ?? "")
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
          value: presenter.item?.episodeAmount == 0
          ? "Unknown" : presenter.item?.episodeAmount.description ?? "Unknown"
        )
        AnimeInformationItem(
          label: "Duration",
          value: presenter.item?.episodeDuration == 0
          ? "Unknown" : presenter.item?.episodeDuration.secondsToHoursMinutes() ?? "Uknown"
        )
        AnimeInformationItem(
          label: "Aired",
          value: "\(presenter.item?.startDate ?? "Unknown") - \(presenter.item?.endDate ?? "Unknown")"
        )
        AnimeInformationItem(
          label: "Studios",
          value: presenter.item?.studios.joined(separator: ", ") ?? "Unknown"
        )
      }
      Spacer()
    }
  }
}
