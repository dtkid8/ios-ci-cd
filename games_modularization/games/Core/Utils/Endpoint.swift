//
//  Endpoint.swift
//  games
//
//  Created by Eric Theo on 09/12/23.
//

import Foundation

struct Endpoint {
  static let baseUrl = "https://api.rawg.io/api/"
  static let listGame = "\(baseUrl)games"
  static let detailGame = "\(baseUrl)games/:id"
}
