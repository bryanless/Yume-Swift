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
      AnimeRequest,
      AnimeDomainModel,
      GetAnimeRepository<
        GetAnimeLocaleDataSource,
        GetAnimeRemoteDataSource,
        AnimeTransformer>>,
    Interactor<
      Int,
      AnimeDomainModel,
      UpdateFavoriteAnimeRepository<
        GetFavoriteAnimeLocaleDataSource,
        AnimeDataTransformer>>>
  @State var scrollOffset: CGFloat

  let anime: AnimeDomainModel

  public init(
    presenter: AnimePresenter<
    Interactor<
    AnimeRequest,
    AnimeDomainModel,
    GetAnimeRepository<
    GetAnimeLocaleDataSource,
    GetAnimeRemoteDataSource,
    AnimeTransformer>>,
    Interactor<
    Int,
    AnimeDomainModel,
    UpdateFavoriteAnimeRepository<
    GetFavoriteAnimeLocaleDataSource,
    AnimeDataTransformer>>>,
    scrollOffset: CGFloat = CGFloat.zero,
    anime: AnimeDomainModel
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
        CustomEmptyView(label: presenter.errorMessage)
      } else {
        content
      }
    }
    .toolbar(.hidden)
    .onAppear {
      if presenter.item == nil {
        presenter.getAnime(request: AnimeRequest(id: anime.id))
      }
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
      }.background(YumeColor.background)

      BackAppBar(scrollOffset: scrollOffset, label: "", trailing: {
        Button {
          presenter.updateFavoriteAnime(request: anime.id)
        } label: {
          IconView(
            icon: presenter.item?.isFavorite ?? anime.isFavorite ? Icons.heart : Icons.heartOutlined,
            color: presenter.item?.isFavorite ?? anime.isFavorite ? YumeColor.primary : YumeColor.onSurface
          )
        }
      })
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
    WebImage(url: URL(string: presenter.item?.mainPicture ?? anime.mainPicture))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFill()
      .frame(width: 120, height: 180)
      .cornerRadius(Shape.rounded)
  }

  var overviewDescription: some View {
    VStack(alignment: .leading) {
      Text("\(presenter.item?.mediaType ?? anime.mediaType)"
           + " · \(presenter.item?.startSeason ?? anime.startSeason)"
           + " \(presenter.item?.startSeasonYear ?? anime.startSeasonYear)"
           + " · \(presenter.item?.status ?? anime.status)"
      ).typography(.caption(color: YumeColor.onSurfaceVariant))

      Text((presenter.item?.alternativeTitleEnglish ?? anime.alternativeTitleEnglish).isEmpty
           ? (presenter.item?.title ?? anime.title)
           : (presenter.item?.alternativeTitleEnglish ?? anime.alternativeTitleEnglish))
      .typography(.title3(color: YumeColor.onBackground))
      .bold()
      .lineLimit(3)

      Text(presenter.item?.source ?? anime.source)
        .typography(.caption2(color: YumeColor.onSurfaceVariant))

      Spacer()

      Text((presenter.item?.genre ?? anime.genre).joined(separator: " · "))
        .typography(.caption(color: YumeColor.onSurfaceVariant))
    }
  }

  var stats: some View {
    HStack(spacing: Space.small) {
      AnimeStatItem(
        icon: Icons.starOutlined,
        iconColor: .yellow,
        label: "score_label".localized(bundle: .module),
        value: (presenter.item?.rating ?? anime.rating).description
      )
      AnimeStatItem(
        icon: Icons.crownOutlined,
        iconColor: .orange,
        label: "rank_label".localized(bundle: .module),
        value: "#\((presenter.item?.rank ?? anime.rank).formatNumber())"
      )
      AnimeStatItem(
        icon: Icons.trendingUp,
        iconColor: .green,
        label: "popularity_label".localized(bundle: .module),
        value: "#\(presenter.item?.popularity.formatNumber() ?? anime.popularity.description)"
      )
      AnimeStatItem(
        icon: Icons.usersOutlined,
        iconColor: .purple,
        label: "members_label".localized(bundle: .module),
        value: (presenter.item?.userAmount ?? anime.userAmount).formatNumber()
      )
      AnimeStatItem(
        icon: Icons.heartOutlined,
        iconColor: .red,
        label: "favorites_label".localized(bundle: .module),
        value: (presenter.item?.favoriteAmount ?? anime.favoriteAmount).formatNumber()
      )
    }.frame(height: 70)
  }

  var synopsis: some View {
    HStack {
      VStack(alignment: .leading, spacing: Space.small) {
        Text("synopsis_label".localized(bundle: .module))
          .typography(.headline(color: YumeColor.onBackground))
        Text(presenter.item?.synopsis ?? anime.synopsis)
          .typography(.body(color: YumeColor.onBackground))
      }
      Spacer()
    }
  }

  var information: some View {
    HStack {
      VStack(alignment: .leading, spacing: Space.small) {
        Text("information_label".localized(bundle: .module))
          .typography(.headline(color: YumeColor.onBackground))
        AnimeInformationItem(
          label: "episodes_label".localized(bundle: .module),
          value: (presenter.item?.episodeAmount ?? anime.episodeAmount) == 0
          ? "unknown_label".localized(bundle: .common)
          : (presenter.item?.episodeAmount ?? anime.episodeAmount).description
        )
        AnimeInformationItem(
          label: "duration_label".localized(bundle: .module),
          value: (presenter.item?.episodeDuration ?? anime.episodeDuration) == ""
          ? "unknown_label".localized(bundle: .common)
          : (presenter.item?.episodeDuration ?? anime.episodeDuration)
        )
        let startDate = presenter.item?.startDate ?? anime.startDate
        let endDate = presenter.item?.endDate ?? anime.endDate
        let airedDate = (startDate == "Unknown" && endDate == "Unknown")
        ? "unknown_label".localized(bundle: .common)
        : ((presenter.item?.startDate ?? anime.startDate) == "Unknown"
           ? "unknown_label".localized(bundle: .common)
           : (presenter.item?.startDate ?? anime.startDate)) + " - "
        + ((presenter.item?.startDate ?? anime.startDate) == "Unknown"
           ? "unknown_label".localized(bundle: .common)
           : (presenter.item?.startDate ?? anime.startDate))
        AnimeInformationItem(
          label: "aired_label".localized(bundle: .module),
          value: airedDate
        )
        AnimeInformationItem(
          label: "studios_label".localized(bundle: .module),
          value: (presenter.item?.studios ?? anime.genre).isEmpty
          ? "unknown_label".localized(bundle: .common)
          : (presenter.item?.studios ?? anime.genre).joined(separator: ", ")
        )
      }
      Spacer()
    }
  }
}
