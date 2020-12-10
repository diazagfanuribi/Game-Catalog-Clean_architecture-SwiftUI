//
//  DeveloperEntity.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 06/12/20.
//

import Foundation
import RealmSwift

class DeveloperEntity: Object {
  @objc dynamic var ids: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var imageUrl: String = ""

  override static func primaryKey() -> String? {
    return "ids"
  }
}
