//
//  File.swift
//  
//
//  Created by Eric Theo on 03/01/24.
//

import Foundation
public struct GameDetailEntity: Codable {
    let id: Int
    let slug, name, nameOriginal, description: String
    let released: String
    let tba: Bool
    let updated: String
    let backgroundImage, backgroundImageAdditional: String
    let website: String
    let rating, ratingTop: Double
    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case nameOriginal = "name_original"
        case description
        case released, tba, updated
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website, rating
        case ratingTop = "rating_top"
    }
}
