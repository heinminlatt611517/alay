//
//  MovieSliderCollectionViewCell.swift
//  Starter
//
//  Created by Sai Xtun on 24/01/2021.
//

import UIKit
import SDWebImage

class MovieSliderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var labelContentTitle: UILabel!
    
    var data: MovieResult? {
        didSet {
            if let data = data {
                let title = data.originalTitle
                let backdroppath = ("\(Constants.baseImageUrl)\(data.backdropPath ?? "")")
                
                labelContentTitle.text = title
                movieImageView.sd_setImage(with: URL(string: backdroppath), placeholderImage: nil, options: .continueInBackground)
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
