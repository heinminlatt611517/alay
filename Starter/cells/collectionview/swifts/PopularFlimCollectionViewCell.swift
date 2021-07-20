//
//  PopularFlimCollectionViewCell.swift
//  Starter
//
//  Created by Sai Xtun on 24/01/2021.
//

import UIKit

class PopularFlimCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var labelContentTitle: UILabel!
    @IBOutlet weak var rating: RatingControl!
    @IBOutlet weak var labelRating: UILabel!
    
    var data: MovieResult? {
        didSet {
            if let data = data {
                let title = data.originalTitle ?? data.originalName
                let backdroppath = ("\(Constants.baseImageUrl)\(data.backdropPath ?? "")")
                
                labelContentTitle.text = title
                movieImageView.sd_setImage(with: URL(string: backdroppath), placeholderImage: nil, options: .continueInBackground)
                labelRating.text = "\(data.voteAverage ?? 0.0)"
                let voteAverate = data.voteAverage ?? 0.0
                //rating.starCount = Int(data.voteAverage ?? 0.0 * 0.5)
                rating.rating = Int(voteAverate * 0.5)
                
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
