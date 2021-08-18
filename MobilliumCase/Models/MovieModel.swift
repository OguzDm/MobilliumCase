//
//  MovieModel.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 16.08.2021.
//

import Foundation

import Foundation

// MARK: - MovieModel
struct MovieModel: Codable {
    let results: [MovieResults]
}

struct MovieResults: Codable {
    let id: Int
    let poster_path: String
    let title: String
    let backdrop_path: String?
    let popularity: Double
    let overview: String
    let release_date: String
    
    var releaseYear:String {
        let year = release_date.split(separator: "-").first?.description ?? "TBA"
        return year
    }
}
