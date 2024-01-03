//
//  File.swift
//  
//
//  Created by Eric Theo on 02/01/24.
//
import Foundation

// MARK: - GameEntity
public struct GameEntity: Codable {
    let count: Int
    let next: String
    let results: [GameEntityResult]
    let seoTitle, seoDescription, seoKeywords, seoH1: String
    let noindex, nofollow: Bool
    let description: String
    let nofollowCollections: [String]

    enum CodingKeys: String, CodingKey {
        case count, next, results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow, description
        case nofollowCollections = "nofollow_collections"
    }
}

// MARK: - Result
public struct GameEntityResult: Codable {
    let id: Int
    let slug, name, released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int
    let ratingsCount, reviewsTextCount, added: Int
    let metacritic, playtime, suggestionsCount: Int
    let updated: String
    let reviewsCount: Int

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case reviewsCount = "reviews_count"
    }
}
