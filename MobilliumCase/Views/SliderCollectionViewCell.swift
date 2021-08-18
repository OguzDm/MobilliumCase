//
//  SliderCollectionViewCell.swift
//  MobilliumCase
//
//  Created by Oguz Demırhan on 18.08.2021.
//

import UIKit
import Kingfisher

final class SliderCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "SliderCollectionViewCell"
    @IBOutlet weak var sliderImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var descriptionNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(image: String, name: String, description: String){
        guard let imageURL = URL(string:Constants.baseLowResImageURL + image) else {return}
        sliderImageView.kf.indicatorType = .activity
        sliderImageView.kf.setImage(with: imageURL)
        movieNameLabel.text = name
        descriptionNameLabel.text = description
    }
}
