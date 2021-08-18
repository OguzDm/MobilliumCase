//
//  SearchModel.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 18.08.2021.
//

import Foundation

struct SearchModel: Codable {
    let results: [SearchResult]
}

struct SearchResult: Codable {
    let id: Int
    let title: String
    let release_date: String
    
    var releaseYear:String {
        let year = release_date.split(separator: "-").first?.description ?? "TBA"
        return year
    }
}
