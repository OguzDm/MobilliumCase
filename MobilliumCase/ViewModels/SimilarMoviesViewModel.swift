//
//  SimilarMoviesViewModel.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 18.08.2021.
//

import Foundation

protocol SimilarMoviesViewModelDelegate:AnyObject {
    func getSimilarMovies()
}

final class SimilarMoviesViewModel {
    weak var delegate: SimilarMoviesViewModelDelegate?
    var movies = [Similar]()
    func fetchSimilarMovies(with id: Int){
        Service.shared.fetchSimilarMovies(with: id) { similar in
            self.movies = similar.results
            self.delegate?.getSimilarMovies()
        }
    }
}
