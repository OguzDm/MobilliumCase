//
//  NowPlayingMovieViewModel.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 16.08.2021.
//

import Foundation

protocol NowPlayingMovieViewModelDelegate: AnyObject {
    func getNowPlayingMovies()
}

class NowPlayingMovieViewModel {
    
    weak var delegate: NowPlayingMovieViewModelDelegate?
    var movies = [MovieResults]()
    func fetchNowPlaying(){
        Service.shared.fetchMovies(endpoint: .NowPlaying) { response in
            self.movies = response.results
            self.delegate?.getNowPlayingMovies()
        }
    }
}
