//
//  File.swift
//  
//
//  Created by Eric Theo on 03/01/24.
//

import Foundation

public struct FavoriteGameModel: Equatable, Identifiable {
  public let id: String
  public let name: String
  public let image: String
  public let released: String
  public let rating: Double
  public init(id: String, name: String, image: String, released: String, rating: Double) {
    self.id = id
    self.name = name
    self.image = image
    self.released = released
    self.rating = rating
  }
}
