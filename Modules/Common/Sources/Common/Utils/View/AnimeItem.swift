//
//  AnimeItem.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Anime
import Core
import SwiftUI
import SDWebImageSwiftUI

public struct AnimeItem: View {
  @State var anime: AnimeDomainModel

  public init(anime: AnimeDomainModel) {
    self.anime = anime
  }

  public var body: some View {
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
      .cornerRadius(Shape.small)
  }

  var content: some View {
    Text(anime.alternativeTitleEnglish.isEmpty
         ? anime.title : anime.alternativeTitleEnglish)
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
