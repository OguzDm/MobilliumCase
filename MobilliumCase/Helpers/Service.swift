//
//  Service.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 16.08.2021.
//

import Foundation
import Alamofire

class Service {
    
    enum Endpoint: String {
        case Upcoming = "upcoming"
        case NowPlaying = "now_playing"
    }
    
    static let shared = Service()
    
    func fetchMovies(endpoint: Endpoint,completionHandler: @escaping (MovieModel) -> ()){
        AF.request(Constants.baseURL + endpoint.rawValue + "?api_key=\(Constants.apiKey)").responseDecodable(of: MovieModel.self) { response in
            switch response.result {
            case .success(let model):
                completionHandler(model)
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
    func searchMovies(){
        
    }
}
