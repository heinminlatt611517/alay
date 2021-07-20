//
//  BestActorCollectionViewCell.swift
//  Starter
//
//  Created by Sai Xtun on 24/01/2021.
//

import UIKit
import SDWebImage
class BestActorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivHeart: UIImageView!
    @IBOutlet weak var ivHeartFill: UIImageView!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var labelContentTitle: UILabel!
    
    weak var delegate : ActorActionDelegate? = nil
    
    var data: ActorResult? {
        didSet {
        if let actordata = data {
            let backdroppath = ("\(Constants.baseImageUrl)\(actordata.profilePath ?? "")")
            self.imageBackground.sd_setImage(with: URL(string: backdroppath), placeholderImage: nil, options: .continueInBackground, context: nil)
            self.labelContentTitle.text = actordata.name
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initGestureRecognizers()
    }
    
    public func initGestureRecognizers() {
        self.ivHeart.isUserInteractionEnabled = true
        self.ivHeartFill.isUserInteractionEnabled = true
        
        self.ivHeart.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapUnFavourite)))
        self.ivHeartFill.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapFavourite)))
    }
    
    @objc func onTapFavourite() {
        self.ivHeart.isHidden = false
        self.ivHeartFill.isHidden = true
        delegate?.onTapFavourite(isFavourite: true)
    }
    
    @objc func onTapUnFavourite() {
        self.ivHeart.isHidden = true
        self.ivHeartFill.isHidden = false
        delegate?.onTapFavourite(isFavourite: false)
    }

}
