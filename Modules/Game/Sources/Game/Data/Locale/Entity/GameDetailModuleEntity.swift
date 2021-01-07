//
//  File.swift
//  
//
//  Created by DiazAgfa on 05/01/21.
//


import Foundation
import RealmSwift

public class GameDetailModuleEntity: Object {
  @objc dynamic var ids: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var rating: Double = 0
  @objc dynamic var released: String = ""
  @objc dynamic var background: String = ""
  @objc dynamic var desc: String = ""
  @objc dynamic var backgroundAdditional: String = ""
  @objc dynamic var website: String = ""
  @objc dynamic var favorite: Bool = false

  public override static func primaryKey() -> String? {
    return "ids"
  }
}
