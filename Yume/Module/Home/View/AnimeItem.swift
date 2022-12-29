//
//  AnimeItem.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct AnimeItem: View {
  @State var anime: AnimeModel

    var body: some View {
      VStack(alignment: .leading, spacing: Space.small) {
        mainPicture
        content
      }
      .frame(width: 100)
    }
}

extension AnimeItem {

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
    Text(anime.title)
      .typography(.caption(color: YumeColor.onBackground))
      .lineLimit(2, reservesSpace: true)
      .padding(
        EdgeInsets(
          top: Space.none,
          leading: Space.tiny,
          bottom: Space.tiny,
          trailing: Space.tiny)
      )
  }

}

struct AnimeItem_Previews: PreviewProvider {
  static let animeRankingsResponse: AnimeRankingsResponse = PreviewData.load("top_all_anime_response")

  static var previews: some View {
    AnimeItem(anime: AnimeRankingMapper.mapAnimeRankingResponsesToDomains(input: animeRankingsResponse.animes).first!)
  }
}
