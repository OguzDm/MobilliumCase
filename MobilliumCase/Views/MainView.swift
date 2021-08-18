//
//  ViewController.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 16.08.2021.
//

import UIKit

final class MainView: UIViewController, UpcomingMovieViewModelDelegate, NowPlayingMovieViewModelDelegate, SearchViewModelDelegate{
    func getSearchResults() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
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
    
    private var collectionView: UICollectionView!
    private var tableView: UITableView!
    private let upComingViewModel = UpcomingMovieViewModel()
    private let nowPlayingViewModel = NowPlayingMovieViewModel()
    private let searchViewModel = SearchViewModel()
    private let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchController()
        navigationItem.searchController = searchController
        searchViewModel.delegate = self
        upComingViewModel.delegate = self
        nowPlayingViewModel.delegate = self
        upComingViewModel.fetchUpcomings()
        nowPlayingViewModel.fetchNowPlaying()
        configureCollectionView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tableView.removeFromSuperview()
        searchViewModel.results.removeAll()
    }
    
    private let gridThenList = UICollectionViewCompositionalLayout { section, env -> NSCollectionLayoutSection? in
        
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
    
    private func configureCollectionView(){
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
    
    func refreshTable(){
        searchViewModel.results.removeAll()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MainView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "MovieDetailView") as! MovieDetailView
        switch indexPath.section {
        case 0:
            detailVC.movieID = nowPlayingViewModel.movies[indexPath.item].id
            navigationController?.pushViewController(detailVC, animated: true)
        default:
            detailVC.movieID = upComingViewModel.movies[indexPath.item].id
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
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
            cell.configure(image: nowPlayingViewModel.movies[indexPath.item].backdrop_path ?? nowPlayingViewModel.movies[indexPath.item].poster_path,
                           name: nowPlayingViewModel.movies[indexPath.item].title + " (\(nowPlayingViewModel.movies[indexPath.item].releaseYear))",
                           description: nowPlayingViewModel.movies[indexPath.item].overview)
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reuseIdentifier, for: indexPath) as! ListCollectionViewCell
            cell.configure(image: upComingViewModel.movies[indexPath.item].poster_path,
                           name: upComingViewModel.movies[indexPath.item].title + " (\(upComingViewModel.movies[indexPath.item].releaseYear))",
                           description: upComingViewModel.movies[indexPath.item].overview)
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
}

//MARK:- SearchTableView

extension MainView {
    func configureTableView(){
        tableView = UITableView(frame: view.bounds)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor.systemBackground
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureSearchController(){
        searchController.searchBar.delegate = self
    }
}

extension MainView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addSubview(tableView)
        refreshTable()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.removeFromSuperview()
        refreshTable()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            searchViewModel.fetchSearch(with: searchText)
        }
    }
}

extension MainView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "MovieDetailView") as! MovieDetailView
        detailVC.movieID = searchViewModel.results[indexPath.row].id
        navigationController?.pushViewController(detailVC, animated: true)
        refreshTable()
    }
}

extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = searchViewModel.results[indexPath.row].title + " (\(searchViewModel.results[indexPath.row].releaseYear))"
        
        return cell
    }
}
