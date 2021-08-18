//
//  MovieDetailView.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 18.08.2021.
//

import UIKit
import Kingfisher
import WebKit

final class MovieDetailView: UIViewController, SimilarMoviesViewModelDelegate, WKNavigationDelegate {
    func getSimilarMovies() {
            self.collectionView.reloadData()
    }
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var similiarMoviesLabel: UILabel!
    
    private var webView: WKWebView!
    private var collectionView: UICollectionView!
    private let movieDetailViewModel = MovieDetailViewModel()
    private let similarMoviesViewModel = SimilarMoviesViewModel()
    var movieID : Int?
    var imdbID = ""
    
    override func viewDidLoad() {
        webView = WKWebView()
        webView.navigationDelegate = self
        similarMoviesViewModel.delegate = self
        super.viewDidLoad()
        configureCollectionView()
        movieDetailViewModel.fetchDetails(with: movieID!) { response in
            guard let imageURL = URL(string: Constants.baseLowResImageURL + response.backdrop_path) else {return}
            self.movieImageView.kf.indicatorType = .activity
            self.movieImageView.kf.setImage(with: imageURL)
            self.ratingLabel.text = String(response.vote_average) + "/10"
            self.dateLabel.text = response.release_date
            self.nameLabel.text = response.title + " (\(response.releaseYear))"
            self.descriptionLabel.text = response.overview
            self.imdbID = response.imdb_id
        }
        similarMoviesViewModel.fetchSimilarMovies(with: movieID!)
    }
    @IBAction func imdbButtonTapped(_ sender: UIButton) {
        let url = URL(string: Constants.imdbMoviePageURL + imdbID )!
        webView.load(URLRequest(url: url))
        view = webView
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.systemBackground
        collectionView.alwaysBounceVertical = false
        collectionView.register(UINib.loadNib(name: SimilarCollectionViewCell.reuseIdentifier), forCellWithReuseIdentifier: SimilarCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: similiarMoviesLabel.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 168)
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(104), heightDimension: .absolute(148))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top:0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(104) , heightDimension: .absolute(148))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item,count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension MovieDetailView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "MovieDetailView") as! MovieDetailView
        detailVC.movieID = similarMoviesViewModel.movies[indexPath.item].id
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MovieDetailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMoviesViewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarCollectionViewCell.reuseIdentifier, for: indexPath) as! SimilarCollectionViewCell
        cell.configure(image: similarMoviesViewModel.movies[indexPath.item].poster_path, name: similarMoviesViewModel.movies[indexPath.item].title + " (\(similarMoviesViewModel.movies[indexPath.item].releaseYear))")
        return cell
    }
}
