//
//  AnimeCardItem.swift
//  Yume
//
//  Created by Bryan on 29/12/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct AnimeCardItem: View {
  @State var anime: AnimeModel

  var body: some View {
    HStack(spacing: Space.small) {
      mainPicture
      content
      Spacer()
    }.frame(height: 150)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(.black, lineWidth: 1)
      )
  }

}

extension AnimeCardItem {

  var mainPicture: some View {
    WebImage(url: URL(string: anime.mainPicture))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFill()
      .frame(width: 100, height: 150)
      .cornerRadius(Shape.rounded)
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
      ).font(.caption)

      Text(anime.title)
        .font(.body)
        .lineLimit(2)
    }
  }

  var tags: some View {
    VStack(alignment: .leading, spacing: Space.tiny) {
      stats
      Text(Array(anime.genre.prefix(3))
        .joined(separator: " · "))
        .font(.caption)
        .lineLimit(1)
    }
  }

  var stats: some View {
    HStack(spacing: Space.small) {
      HStack(spacing: Space.tiny) {
        Image(systemName: Icons.starOutlined)
          .foregroundColor(.yellow)
          .font(.system(size: 16))
        Text(anime.rating.description)
          .font(.caption)
      }
      HStack(spacing: Space.tiny) {
        Image(systemName: Icons.crownOutlined)
          .foregroundColor(.yellow)
          .font(.system(size: 16))
        Text(anime.rank.description)
          .font(.caption)
      }
      HStack(spacing: Space.tiny) {
        Image(systemName: Icons.chartLineUpTrendXyaxisOutlined)
          .foregroundColor(.green)
          .font(.system(size: 16))
        Text(anime.popularity.description)
          .font(.caption)
      }
    }
  }
}

struct AnimeCardItem_Previews: PreviewProvider {
  static let animeRankingsResponse: AnimeRankingsResponse = PreviewData.load("top_all_anime_response")

  static var previews: some View {
    AnimeCardItem(
      anime: AnimeRankingMapper.mapAnimeRankingResponsesToDomains(
        input: animeRankingsResponse.animes
      ).first!
    )
  }
}
