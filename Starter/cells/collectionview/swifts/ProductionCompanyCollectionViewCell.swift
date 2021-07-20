//
//  ProductionCompanyCollectionViewCell.swift
//  Starter
//
//  Created by Admin on 29/06/2021.
//

import UIKit
import SDWebImage

class ProductionCompanyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var labelContentTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var data: ProductionCompany? {
        didSet {
            if let data = data {
                if data.logoPath == nil || data.logoPath!.isEmpty {
                    self.labelContentTitle.text = data.name

                }else {
                    self.labelContentTitle.text = ""
                }
                let backdroppath = ("\(Constants.baseImageUrl)\(data.logoPath ?? "")")
                self.backgroundImageView.sd_setImage(with: URL(string: backdroppath), placeholderImage: nil, options: .continueInBackground, context: nil)
            }
        }
    }

}
