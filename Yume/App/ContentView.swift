//
//  ContentView.swift
//  Yume
//
//  Created by Bryan on 25/12/22.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: HomePresenter

  var body: some View {
    HomeView(presenter: homePresenter)
  }
}

struct ContentView_Previews: PreviewProvider {
  static let homeUseCase = Injection.init().provideHome()

  static let homePresenter = HomePresenter(homeUseCase: homeUseCase)

  static var previews: some View {
    ContentView()
      .environmentObject(homePresenter)
  }
}
