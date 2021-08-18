//
//  MovieDetailView.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 18.08.2021.
//

import UIKit
import Kingfisher

final class MovieDetailView: UIViewController {
    
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var similiarMoviesLabel: UILabel!
    
    private var collectionView: UICollectionView!
    let movieDetailViewModel = MovieDetailViewModel()
    var movieID : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailViewModel.fetchDetails(with: movieID!) { response in
            guard let imageURL = URL(string: Constants.baseLowResImageURL + response.backdrop_path) else {return}
            self.movieImageView.kf.setImage(with: imageURL)
            self.ratingLabel.text = String(response.vote_average) + "/10"
            self.dateLabel.text = response.release_date
            self.nameLabel.text = response.original_title
            self.descriptionLabel.text = response.overview
        }
        
        
    }
    @IBAction func imdbButtonTapped(_ sender: UIButton) {
        
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.loadNib(name: SimilarCollectionViewCell.reuseIdentifier), forCellWithReuseIdentifier: SimilarCollectionViewCell.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            collectionView.topAnchor.constraint(equalTo: similiarMoviesLabel.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(104), heightDimension: .absolute(148))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top:0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(104) , heightDimension: .absolute(148))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item,count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = 8
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension MovieDetailView: UICollectionViewDelegate {
    
}

extension MovieDetailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
}
