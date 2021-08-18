//
//  ViewController.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 16.08.2021.
//

import UIKit

class MainView: UIViewController, UpcomingMovieViewModelDelegate, NowPlayingMovieViewModelDelegate{
    func getNowPlayingMovies() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func getUpcomingMovies() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    var collectionView: UICollectionView!
    let upComingViewModel = UpcomingMovieViewModel()
    let nowPlayingViewModel = NowPlayingMovieViewModel()
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        upComingViewModel.delegate = self
        nowPlayingViewModel.delegate = self
        upComingViewModel.fetchUpcomings()
        nowPlayingViewModel.fetchNowPlaying()
        configureCollectionView()
    }
    

    let gridThenList = UICollectionViewCompositionalLayout { section, env -> NSCollectionLayoutSection? in
        
        if section == 0 {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(256))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(256))
            let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
            
            return layoutSection
        }
        else if section == 1 {
            return NSCollectionLayoutSection.list(
                using: UICollectionLayoutListConfiguration(appearance: .plain),
                layoutEnvironment: env
            )
        }
        
        return NSCollectionLayoutSection.list(
            using: UICollectionLayoutListConfiguration(appearance: .plain),
            layoutEnvironment: env
        )
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: gridThenList)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UINib.loadNib(name: SliderCollectionViewCell.reuseIdentifier), forCellWithReuseIdentifier: SliderCollectionViewCell.reuseIdentifier)
        collectionView.register(UINib.loadNib(name: ListCollectionViewCell.reuseIdentifier), forCellWithReuseIdentifier: ListCollectionViewCell.reuseIdentifier)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
}

extension MainView: UICollectionViewDelegate {
    
}

extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return nowPlayingViewModel.movies.count
        default:
            return upComingViewModel.movies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCollectionViewCell.reuseIdentifier, for: indexPath) as! SliderCollectionViewCell
            cell.configure(image: nowPlayingViewModel.movies[indexPath.item].backdrop_path ?? nowPlayingViewModel.movies[indexPath.item].poster_path, name: nowPlayingViewModel.movies[indexPath.item].original_title, description: nowPlayingViewModel.movies[indexPath.item].overview)
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reuseIdentifier, for: indexPath) as! ListCollectionViewCell
            cell.configure(image: upComingViewModel.movies[indexPath.item].poster_path, name: upComingViewModel.movies[indexPath.item].original_title, description: upComingViewModel.movies[indexPath.item].overview)
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
}

