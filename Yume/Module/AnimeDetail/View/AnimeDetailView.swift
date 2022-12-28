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
          HStack(alignment: .top, spacing: Space.small) {
            mainPicture
            content
          }
        }.navigationBarTitleDisplayMode(.inline)
      }
    }
  }
}

extension AnimeDetailView {

  var mainPicture: some View {
    WebImage(url: URL(string: self.presenter.anime.mainPicture))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFill()
      .frame(width: 120, height: 180)
      .cornerRadius(Shape.rounded)
  }

  var content: some View {
    Text(self.presenter.anime.title)
      .font(.title3)
      .bold()
      .lineLimit(2)
  }

}
