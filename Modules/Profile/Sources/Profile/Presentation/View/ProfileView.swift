//
//  ProfileView.swift
//  
//
//  Created by Bryan on 08/01/23.
//

import Common
import Core
import SwiftUI

public struct ProfileView: View {
  @State var scrollOffset: CGFloat

  public init(scrollOffset: CGFloat = CGFloat.zero) {
    self.scrollOffset = scrollOffset
  }

  public var body: some View {
    ZStack(alignment: .top) {
      ObservableScrollView(scrollOffset: $scrollOffset, showsIndicators: false) { _ in
        VStack(spacing: Space.large) {
          profile
        }
        .padding(
          EdgeInsets(
            top: 0,
            leading: Space.none,
            bottom: Space.medium,
            trailing: Space.none)
        )
      }.background(YumeColor.background)

      AppBar(scrollOffset: scrollOffset, label: "profile_title".localized(bundle: .common))
    }
  }
}

extension ProfileView {
  var profile: some View {
    VStack(spacing: Space.none) {
      profileBackground
      HStack {
        VStack(alignment: .leading, spacing: Space.small) {
          profilePicture

          VStack(alignment: .leading, spacing: Space.tiny) {
            Text("Bryan")
              .typography(.title2(weight: .bold))
            Text(verbatim: "bryan001@student.ciputra.ac.id")
              .typography(.caption(color: YumeColor.onSurfaceVariant))
          }        }
        Spacer()
      }
      .padding(.horizontal, 16)
    }
  }

  var profileBackground: some View {
    Rectangle()
      .fill(Formatter.rgbToColor(red: 201, green: 203, blue: 202))
      .frame(height: 100)
  }

  var profilePicture: some View {
    CircleImage(image: Image("ProfilePicture", bundle: .module))
      .frame(width: 80, height: 80)
      .overlay {
        Circle().stroke(.white, lineWidth: 2)
      }
      .offset(y: -40)
      .padding(.bottom, -40)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
