//
//  SearchViewModel.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 16.08.2021.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func getSearchResults()
}

class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?
    var results = [SearchResult]()
    
    func fetchSearch(with query: String) {
        Service.shared.searchMovies(with: query) { model in
            self.results = model.results
            self.delegate?.getSearchResults()
        }
    }
}
