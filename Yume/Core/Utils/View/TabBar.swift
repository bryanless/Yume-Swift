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
        label: "Home",
        isActive: selection == .home
      ) {
        selection = .home
      }

      TabItem(
        icon: Icons.search,
        label: "Search",
        isActive: selection == .search
      ) {
        selection = .search
      }

      TabItem(
        icon: selection == .favorite ? Icons.heart : Icons.heartOutlined,
        label: "Favorite",
        isActive: selection == .favorite
      ) {
        selection = .favorite
      }

      TabItem(
        icon: selection == .profile ? Icons.user : Icons.userOutlined,
        label: "Profile",
        isActive: selection == .profile
      ) {
        selection = .profile
      }
    }
    .frame(height: 56.0)
    .padding(.horizontal, Space.medium)
    .background(YumeColor.surface)
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
