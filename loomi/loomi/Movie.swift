//
//  Movie.swift
//  loomi
//
//  Created by Janna Qian Zi Ng on 12/2/25.
//

import Foundation

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
//  Created by Andrew Wang on 2/12/2025.
//these are the variables working on the RootTabView

import Foundation

struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let poster: String
}
