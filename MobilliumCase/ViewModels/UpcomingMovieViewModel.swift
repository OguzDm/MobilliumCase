//
//  MovieViewModel.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 16.08.2021.
//

import Foundation

protocol UpcomingMovieViewModelDelegate: AnyObject {
    func getUpcomingMovies()
}

class UpcomingMovieViewModel {
    
    weak var delegate: UpcomingMovieViewModelDelegate?
    var movies = [MovieResults]()
    func fetchUpcomings(){
        Service.shared.fetchMovies(endpoint: .Upcoming) { response in
            self.movies = response.results
            self.delegate?.getUpcomingMovies()
        }
    }
}
