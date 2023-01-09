//
//  AnimeRow.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Anime
import SwiftUI

public struct AnimeRow: View {
  @State var animes: [AnimeDomainModel]

    public var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: Space.small) {
          ForEach(animes) { anime in
            AnimeItem(anime: anime)
          }
        }
      }
    }
}
