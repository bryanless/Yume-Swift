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
          VStack(alignment: .leading, spacing: Space.large) {
            overview
          }.padding(Space.medium)
        }
        .navigationBarTitleDisplayMode(.inline)
      }
    }
  }
}

extension AnimeDetailView {
  var overview: some View {
    HStack(alignment: .top, spacing: Space.small) {
      mainPicture
      overviewDescription
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
      HStack {
        Text("\(self.presenter.anime.mediaType)"
             + " · \(self.presenter.anime.startSeason) \(self.presenter.anime.startSeasonYear)"
             + " · \(self.presenter.anime.status)"
        ).font(.caption)
      }

      Text(self.presenter.anime.title)
        .font(.title3)
        .bold()
        .lineLimit(2)

      Text(self.presenter.anime.source)
        .font(.caption2)

      Spacer()

      Text(self.presenter.anime.genre.joined(separator: " · "))
        .font(.caption)
    }
  }

}
