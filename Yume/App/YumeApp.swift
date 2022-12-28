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

    let homePresenter = HomePresenter(homeUseCase: homeUseCase)
    let searchPresenter = SearchPresenter(searchUseCase: searchUseCase)

    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
        .environmentObject(searchPresenter)
    }
  }
}
