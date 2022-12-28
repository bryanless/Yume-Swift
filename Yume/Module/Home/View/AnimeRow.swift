//
//  AnimeRow.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct AnimeRow: View {
  @State var animes: [AnimeModel]

    var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(animes) { anime in
            AnimeItem(anime: anime)
          }
        }
      }
    }
}

struct AnimeRow_Previews: PreviewProvider {
  static let animeRankingsResponse: AnimeRankingsResponse = PreviewData.load("top_all_anime_response")

  static var previews: some View {
    AnimeRow(animes: AnimeRankingMapper.mapAnimeRankingResponsesToDomains(input: animeRankingsResponse.animes))
  }
}
