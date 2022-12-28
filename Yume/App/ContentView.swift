//
//  ContentView.swift
//  Yume
//
//  Created by Bryan on 25/12/22.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var searchPresenter: SearchPresenter
  @State private var selection: Tab = .home

  enum Tab {
    case home, search, favorite, profile
  }

  var body: some View {
    TabView {
      HomeView(presenter: homePresenter)
        .tabItem {
          Label("Home", systemImage: "house")
        }
        .tag(Tab.home)
      SearchView(presenter: searchPresenter)
        .tabItem {
          Label("Search", systemImage: "magnifyingglass")
        }
        .tag(Tab.search)
      //        Favorite()
      //            .tabItem {
      //                Label("Favorite", systemImage: Icons.heart)
      //            }
      //            .tag(Tab.favorite)
      //        Profile()
      //            .tabItem {
      //                Label("Profile", systemImage: Icons.person)
      //            }
      //            .tag(Tab.profile)
    }

  }
}

struct ContentView_Previews: PreviewProvider {
  static let homeUseCase = Injection.init().provideHome()
  static let searchUseCase = Injection.init().provideSearch()

  static let homePresenter = HomePresenter(homeUseCase: homeUseCase)
  static let searchPresenter = SearchPresenter(searchUseCase: searchUseCase)

  static var previews: some View {
    ContentView()
      .environmentObject(homePresenter)
      .environmentObject(searchPresenter)
  }
}
