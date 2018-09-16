//
//  ShowDetail.swift
//  TMDbCore
//
//  Created by Juan Foncuberta on 15/9/18.
//  Copyright © 2018 Guille Gonzalez. All rights reserved.
//

import Foundation

struct ShowDetail: Decodable {
    let backdropPath: String?
    let identifier: Int64
    let overview: String?
    let posterPath: String?
    let firstAirDate: Date?
    let seasons: Int64?
    let name: String
    let genreIdentifiers: [Int]
    let credits: Credits?
    
    private enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case identifier = "id"
        case overview
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case seasons = "number_of_seasons"
        case name
        case genreIdentifiers = "genre_ids"
        case credits
    }
}

