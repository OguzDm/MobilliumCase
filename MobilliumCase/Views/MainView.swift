//
//  ViewController.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 16.08.2021.
//

import UIKit

class MainView: UIViewController, UpcomingMovieViewModelDelegate, NowPlayingMovieViewModelDelegate{
    func getNowPlayingMovies() {
        collectionView.reloadData()
    }
    
    func getUpcomingMovies() {
        tableView.reloadData()
    }
    
    let collectionView = UICollectionView(frame: .zero)
    let tableView = UITableView(frame: .zero)
    let upComingViewModel = UpcomingMovieViewModel()
    let nowPlayingViewModel = NowPlayingMovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upComingViewModel.delegate = self
        nowPlayingViewModel.delegate = self
    }
}

