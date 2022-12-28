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

    let homePresenter = HomePresenter(homeUseCase: homeUseCase)

    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
    }
  }
}
