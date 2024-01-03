//
//  File.swift
//  
//
//  Created by Eric Theo on 02/01/24.
//

public struct GameModel: Equatable, Identifiable {
  public let id: String
  public let name: String
  public let image: String
  public let released: String
  public let rating: Double
  static func mapGameEntityToModel(input gameEntity: GameEntity) -> [GameModel] {
    return gameEntity.results.map { result in
      return GameModel(id: String(result.id),
                       name: result.name,
                       image: result.backgroundImage,
                       released: result.released,
                       rating: result.rating)
    }
  }
  public init(id: String, name: String, image: String, released: String, rating: Double) {
    self.id = id
    self.name = name
    self.image = image
    self.released = released
    self.rating = rating
  }
}
