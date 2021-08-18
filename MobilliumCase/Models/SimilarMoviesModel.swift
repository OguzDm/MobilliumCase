//
//  SimilarMoviesModel.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 18.08.2021.
//

import Foundation

struct SimilarMoviesModel: Codable {
    let results: [Similar]
}

struct Similar: Codable {
    let id: Int
    let title: String
    let release_date: String
    let poster_path: String
    
    var releaseYear:String {
        let year = release_date.split(separator: "-").first?.description ?? "TBA"
        return year
    }
}
