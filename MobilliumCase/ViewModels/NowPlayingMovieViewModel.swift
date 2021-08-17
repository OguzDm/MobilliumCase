//
//  NowPlayingMovieViewModel.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 16.08.2021.
//

import Foundation

class NowPlayingMovieViewModel {
    
    func fetchNowPlaying(){
        Service.shared.fetchMovies(endpoint: .NowPlaying) { response in
            print(response.results[0].original_title)
        }
    }
}
