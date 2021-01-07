//
//  File.swift
//  
//
//  Created by DiazAgfa on 05/01/21.
//


import Foundation
import RealmSwift

public class DeveloperModuleEntity: Object {
  @objc dynamic var ids: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var imageUrl: String = ""

  public override static func primaryKey() -> String? {
    return "ids"
  }
}
