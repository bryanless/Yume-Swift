//
//  File+Ext.swift
//  Yume
//
//  Created by Bryan on 06/02/23.
//

import Foundation

struct File {
  static func loadFile(
    forResource resource: String,
    ofType type: String) -> String {
    guard let filePath = Bundle.main.path(forResource: resource, ofType: type) else {
      fatalError("Couldn't find file '\(resource).\(type)'.")
    }

    return filePath
  }

  static func loadDictionaryKey(
    forKey key: String,
    forResource resource: String,
    ofType type: String) -> Any {
      let filePath = loadFile(forResource: resource, ofType: type)

      let plist = NSDictionary(contentsOfFile: filePath)
      guard let value = plist?.object(forKey: "API_KEY") else {
        fatalError("Couldn't find key '\(key)' in '\(resource).\(type)'.")
      }

      return value
    }
}
