//
//  MovieDetailModel.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 16.08.2021.
//

import Foundation

struct MovieDetailModel: Codable {
    let original_title: String
    let overview: String
    let release_date: String
    let runtime: Int?
    let vote_average: Double
    let backdrop_path: String
    let imdb_id: String
    
    var releaseYear:String {
        let year = release_date.split(separator: "-").first?.description ?? "TBA"
        return year
    }
}
