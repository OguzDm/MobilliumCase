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

final class NowPlayingMovieViewModel {
    
    weak var delegate: NowPlayingMovieViewModelDelegate?
    var movies = [MovieResults]()
    func fetchNowPlaying(page: Int){
        Service.shared.fetchMovies(endpoint: .NowPlaying,page: page) { response in
            self.movies.append(contentsOf: response.results)
            self.delegate?.getNowPlayingMovies()
        }
    }
}
