//
//  GameDetailEntity.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 06/12/20.
//

import Foundation
import RealmSwift

class GameDetailEntity: Object {
  @objc dynamic var ids: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var rating: Double = 0
  @objc dynamic var released: String = ""

  @objc dynamic var background: String = ""
  @objc dynamic var desc: String = ""
  @objc dynamic var backgroundAdditional: String = ""
  @objc dynamic var website: String = ""
  @objc dynamic var favorite: Bool = false

  override static func primaryKey() -> String? {
    return "ids"
  }
}
