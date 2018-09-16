//
//  DetailHeader+ShowDetail.swift
//  TMDbCore
//
//  Created by Juan Foncuberta on 16/9/18.
//  Copyright © 2018 Guille Gonzalez. All rights reserved.
//

import Foundation


extension DetailHeader {
    init(show: ShowDetail) {
        title = show.name
        posterPath = show.posterPath
        backdropPath = show.backdropPath
        
        let year = (show.firstAirDate?.year).map { String($0) }
        let duration = "\(show.seasons ?? 0) seasons."
        
        metadata = [year, duration].compactMap { $0 }.joined(separator: " - ")
    }
}
