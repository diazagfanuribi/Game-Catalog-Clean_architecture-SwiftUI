//
//  ApiCall.swift
//  Game Catalog SwiftUI
//
//  Created by DiazAgfa on 10/11/20.
//

import Foundation

struct API {
  static let baseUrl = "https://api.rawg.io/api/"

}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  enum Gets: Endpoint {
    case developer
    case search
    case games
    case detail

    public var url: String {
      switch self {
      case .developer: return "\(API.baseUrl)developers?key=fc062172c4ed48df8e7b9b99d442ded8"
      case .search: return "\(API.baseUrl)games?search=Avenger"
      case .games: return "\(API.baseUrl)games?ordering=-rating&key=fc062172c4ed48df8e7b9b99d442ded8&page_size=15"
      case .detail: return "\(API.baseUrl)games/"
      }
    }
  }

}
