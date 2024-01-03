//
//  File.swift
//  
//
//  Created by Eric Theo on 03/01/24.
//

import Foundation

public struct GameDetailModel: Equatable, Identifiable {
  public let id: String
  public let slug, name, nameOriginal, gameDescription: String
  public let released: String
  public let tba: Bool
  public let updated: String
  public let backgroundImage, backgroundImageAdditional: String
  public let website: String
  public let rating: Double
  public let ratingTop: Double
  public static func mapGameDetailEntityToModel(entity: GameDetailEntity) -> GameDetailModel {
    return GameDetailModel(
      id: String(entity.id),
      slug: entity.slug,
      name: entity.name,
      nameOriginal: entity.nameOriginal,
      gameDescription: entity.description,
      released: entity.released,
      tba: entity.tba,
      updated: entity.updated,
      backgroundImage: entity.backgroundImage,
      backgroundImageAdditional: entity.backgroundImageAdditional,
      website: entity.website,
      rating: entity.rating,
      ratingTop: entity.ratingTop
    )
  }
  public func getGameDescription() -> String {
    return gameDescription
      .replacingOccurrences(of: "<p>", with: "")
      .replacingOccurrences(of: "</p>", with: "")
      .replacingOccurrences(of: "<br />", with: "\n")
  }
}
