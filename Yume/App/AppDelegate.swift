//
//  AppDelegate.swift
//  Yume
//
//  Created by Bryan on 07/01/23.
//

import RealmSwift
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
  static private (set) var instance: AppDelegate! = nil
  var realm: Realm!

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    AppDelegate.instance = self
    realm = try! Realm()

    return true
  }
}
