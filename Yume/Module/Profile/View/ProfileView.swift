//
//  ProfileView.swift
//  Yume
//
//  Created by Bryan on 31/12/22.
//

import SwiftUI

struct ProfileView: View {
  @State var scrollOffset = CGFloat.zero

  var body: some View {
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
      AppBar(scrollOffset: scrollOffset, label: "Profile")
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
    CircleImage(image: Image("ProfilePicture"))
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
