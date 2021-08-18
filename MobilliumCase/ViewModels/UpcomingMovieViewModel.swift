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

final class UpcomingMovieViewModel {
    
    weak var delegate: UpcomingMovieViewModelDelegate?
    var movies = [MovieResults]()
    func fetchUpcomings(page: Int){
        Service.shared.fetchMovies(endpoint: .Upcoming,page: page) { response in
            self.movies.append(contentsOf: response.results)
            self.delegate?.getUpcomingMovies()
        }
    }
}
