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
      case .developer: return "\(API.baseUrl)developers?key=f942ea3f14aa47d1907cc9b86fa1caae"
      case .search: return "\(API.baseUrl)games?search=Avenger"
      case .games: return "\(API.baseUrl)games?ordering=-rating&key=f942ea3f14aa47d1907cc9b86fa1caae&page_size=15"
      case .detail: return "\(API.baseUrl)games/"
      }
    }
  }
  
}
