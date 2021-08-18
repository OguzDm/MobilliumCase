//
//  ListCollectionViewCell.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 18.08.2021.
//

import UIKit
import Kingfisher

final class ListCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ListCollectionViewCell"
    
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        listImageView.layer.cornerRadius = 16
    }
    
    func configure(image: String, name: String, description: String) {
        guard let imageURL = URL(string: Constants.baseLowResImageURL + image) else {return}
        listImageView.kf.indicatorType = .activity
        listImageView.kf.setImage(with: imageURL)
        movieNameLabel.text = name
        descriptionLabel.text = description
    }
}
