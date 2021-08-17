//
//  MovieViewModel.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 16.08.2021.
//

import Foundation

class UpcomingMovieViewModel {
    
    func fetchUpcomings(){
        Service.shared.fetchMovies(endpoint: .Upcoming) { response in
            print(response.results[0].original_title)
        }
    }
}
