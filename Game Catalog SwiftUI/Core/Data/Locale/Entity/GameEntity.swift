//
//  GameEntity.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 06/12/20.
//

import Foundation
import RealmSwift

class GameEntity: Object {
  @objc dynamic var ids: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var released: String = ""
  @objc dynamic var rating: Double = 0
  @objc dynamic var background: String = ""

  override static func primaryKey() -> String? {
    return "ids"
  }
}
