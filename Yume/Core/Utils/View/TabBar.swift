//
//  TabBar.swift
//  Yume
//
//  Created by Bryan on 29/12/22.
//

import SwiftUI

struct TabBar: View {
  @Binding var selection: Tab

  var body: some View {
    HStack(alignment: .center) {
      TabItem(
        icon: selection == .home ? Icons.house : Icons.houseOutlined,
        label: "Home"
      )
      .onTapGesture {
        withAnimation(.easeIn(duration: 0.1)) {
          selection = .home
        }
      }

      TabItem(
        icon: Icons.search,
        label: "Search"
      )
      .onTapGesture {
        withAnimation(.easeIn(duration: 0.1)) {
          selection = .search
        }
      }

      TabItem(
        icon: selection == .favorite ? Icons.heart : Icons.heartOutlined,
        label: "Favorite"
      )
      .onTapGesture {
        withAnimation(.easeIn(duration: 0.1)) {
          selection = .favorite
        }
      }

      TabItem(
        icon: selection == .profile ? Icons.user : Icons.userOutlined,
        label: "Profile"
      )
      .onTapGesture {
        withAnimation(.easeIn(duration: 0.1)) {
          selection = .profile
        }
      }
    }
    .frame(height: 56.0)
    .padding(.horizontal, Space.medium)
  }
}

enum Tab {
  case home, search, favorite, profile
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
      TabBar(selection: .constant(.home))
    }
}
