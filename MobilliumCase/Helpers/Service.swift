//
//  Service.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 16.08.2021.
//

import Foundation
import Alamofire

final class Service {
    
    enum Endpoint: String {
        case Upcoming = "upcoming"
        case NowPlaying = "now_playing"
    }
    
    static let shared = Service()
    
    func fetchMovies(endpoint: Endpoint,page: Int,completionHandler: @escaping (MovieModel) -> ()){
        AF.request(Constants.baseURL + endpoint.rawValue + "?api_key=\(Constants.apiKey)&" + "page=\(page)").responseDecodable(of: MovieModel.self) { response in
            switch response.result {
            case .success(let model):
                completionHandler(model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func searchMovies(with query: String,completionHandler: @escaping (SearchModel) -> ()){
        AF.request(Constants.baseMovieSearchURL + "?api_key=\(Constants.apiKey)&" + "query=\(query)").responseDecodable(of:SearchModel.self) { response in
            switch response.result {
            case .success(let model):
                completionHandler(model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchDetails(with id: Int,completionHandler: @escaping (MovieDetailModel) -> ()) {
        AF.request(Constants.baseURL + "\(id)?" + "api_key=\(Constants.apiKey)").responseDecodable(of: MovieDetailModel.self) { response in
            switch response.result {
            case .success(let model):
                completionHandler(model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchSimilarMovies(with id: Int,completionHandler: @escaping (SimilarMoviesModel) -> ()){
        AF.request(Constants.baseURL + "\(id)/" + "similar?" + "api_key=\(Constants.apiKey)").responseDecodable(of: SimilarMoviesModel.self) {
            response in
            switch response.result {
            case .success(let model):
                completionHandler(model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
