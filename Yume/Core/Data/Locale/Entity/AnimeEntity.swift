//
//  AnimeEntity.swift
//  Yume
//
//  Created by Bryan on 28/12/22.
//

import Foundation
import RealmSwift

class AnimeEntity: Object {

  @Persisted var id: Int = 0
  @Persisted var title: String = ""
  @Persisted var mainPicture: String = ""

  override static func primaryKey() -> String? {
    return "id"
  }
}
