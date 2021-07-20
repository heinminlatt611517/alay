//
//  ShowCaseCollectionViewCell.swift
//  Starter
//
//  Created by Sai Xtun on 24/01/2021.
//

import UIKit
import SDWebImage
class ShowCaseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var labelContentTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var showCaseData: MovieResult? {
        didSet {
            if let data = showCaseData {
                self.labelContentTitle.text = data.originalTitle
                self.labelDate.text = data.releaseDate
                
                let backdroppath = ("\(Constants.baseImageUrl)\(data.backdropPath ?? "")")
                self.imageBackground.sd_setImage(with: URL(string: backdroppath), placeholderImage: nil, options: .continueInBackground, context: nil)
            }
        }
    }

}
