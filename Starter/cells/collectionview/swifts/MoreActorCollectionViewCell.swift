//
//  MoreActorCollectionViewCell.swift
//  Starter
//
//  Created by Admin on 07/07/2021.
//

import UIKit
import SDWebImage

class MoreActorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var labelContentTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var data: ActorResult? {
        didSet {
        if let actordata = data {
            let backdroppath = ("\(Constants.baseImageUrl)\(actordata.profilePath ?? "")")
            self.backgroundImageView.sd_setImage(with: URL(string: backdroppath), placeholderImage: nil, options: .continueInBackground, context: nil)
            self.labelContentTitle.text = actordata.name
            }
        }
    }
    

}
