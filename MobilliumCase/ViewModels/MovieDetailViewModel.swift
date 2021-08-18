//
//  MovieDetailViewModel.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 18.08.2021.
//

import Foundation

final class MovieDetailViewModel {
    
    func fetchDetails(with id: Int,completionHandler: @escaping (MovieDetailModel) -> ()) {
        Service.shared.fetchDetails(with: id) { response in
            completionHandler(response)
        }
    }
}
