//
//  YumeApp.swift
//  Yume
//
//  Created by Bryan on 25/12/22.
//

import SwiftUI

@main
struct YumeApp: App {
  var body: some Scene {
    let homeUseCase = Injection.init().provideHome()
    let searchUseCase = Injection.init().provideSearch()
    let favoriteUseCase = Injection.init().provideFavorite()

    let homePresenter = HomePresenter(homeUseCase: homeUseCase)
    let searchPresenter = SearchPresenter(searchUseCase: searchUseCase)
    let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)

    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
        .environmentObject(searchPresenter)
        .environmentObject(favoritePresenter)
    }
  }
}
