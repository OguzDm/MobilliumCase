//
//  SimilarCollectionViewCell.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 18.08.2021.
//

import UIKit
import Kingfisher

class SimilarCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "SimilarCollectionViewCell"
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImageView.layer.cornerRadius = 16
    }
    
    func configure(image:String, name: String){
        guard let imageURL = URL(string: Constants.baseLowResImageURL + image) else {return}
        movieImageView.kf.setImage(with: imageURL)
        movieNameLabel.text = name
    }
}
