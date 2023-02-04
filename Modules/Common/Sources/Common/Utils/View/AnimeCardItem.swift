//
//  AnimeCardItem.swift
//  Yume
//
//  Created by Bryan on 29/12/22.
//

import Anime
import Core
import SwiftUI
import SDWebImageSwiftUI

public struct AnimeCardItem: View {
  @State var anime: AnimeDomainModel

  public init(anime: AnimeDomainModel) {
    self.anime = anime
  }

  public var body: some View {
    HStack(spacing: Space.small) {
      mainPicture
      content
      Spacer()
    }
    .frame(height: 150)
    .background(YumeColor.surface)
    .overlay(
      RoundedRectangle(cornerRadius: 8)
        .stroke(YumeColor.outline, lineWidth: 1)
    )
  }

}

extension AnimeCardItem {

  var mainPicture: some View {
    WebImage(url: URL(string: anime.mainPicture))
      .resizable()
      .placeholder {
        ImagePlaceholder()
      }
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFill()
      .frame(width: 100, height: 150)
      .cornerRadius(Shape.small)
  }

  var content: some View {
    VStack(alignment: .leading, spacing: Space.small) {
      overview
      Spacer()
      tags
    }.padding(
      EdgeInsets(
        top: Space.small,
        leading: Space.none,
        bottom: Space.small,
        trailing: Space.medium
      )
    )
  }

  var overview: some View {
    VStack(alignment: .leading, spacing: Space.tiny) {
      Text("\(anime.mediaType)"
           + " · \(anime.startSeason) \(anime.startSeasonYear)"
           + " · \(anime.status)"
      ).typography(.caption(color: YumeColor.onSurfaceVariant))

      Text(anime.alternativeTitleEnglish.isEmpty
           ? anime.title : anime.alternativeTitleEnglish)
        .typography(.body(color: YumeColor.onSurface))
        .lineLimit(2)
    }
  }

  var tags: some View {
    VStack(alignment: .leading, spacing: Space.tiny) {
      stats
      Text(Array(anime.genre.prefix(3))
        .joined(separator: " · "))
      .lineLimit(1)
    }.typography(.caption(color: YumeColor.onSurfaceVariant))
  }

  var stats: some View {
    HStack(spacing: Space.small) {
      HStack(spacing: Space.tiny) {
        IconView(
          icon: Icons.starOutlined,
          color: .yellow,
          size: IconSize.small
        )
        Text(anime.rating.description)
          .typography(.caption(color: YumeColor.onSurfaceVariant))
      }
      HStack(spacing: Space.tiny) {
        IconView(
          icon: Icons.crownOutlined,
          color: .orange,
          size: IconSize.small
        )
        Text("#\(anime.rank.formatNumber())")
          .typography(.caption(color: YumeColor.onSurfaceVariant))
      }
      HStack(spacing: Space.tiny) {
        IconView(
          icon: Icons.trendingUp,
          color: .green,
          size: IconSize.small
        )
        Text("#\(anime.popularity.formatNumber())")
          .typography(.caption(color: YumeColor.onSurfaceVariant))
      }
    }
  }
}
