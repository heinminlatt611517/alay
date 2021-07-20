//
//  MovieTypeCollectionViewCell.swift
//  Starter
//
//  Created by MML on 11/06/2021.
//

import UIKit

class MovieTypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelMovieType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 5
    }

}
