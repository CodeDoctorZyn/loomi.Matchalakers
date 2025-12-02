//
//  Movie.swift
//  loomi
//
//  Created by Janna Qian Zi Ng on 12/2/25.
//

import Foundation

// Primary Movie model used across the app
struct Movie: Codable, Identifiable {
    let id: Int
    let name: String
    let values: [String]
    let suitableAge: String
    let genres: [String]
    let movieAgeRating: String
    let length: Int
    let releasedDate: String
    let synopsis: String
    let posterPortrait: String
    let posterLandscape: String
    let trailerID: String
    let popularity: String
}

