//
//  MovieShowTimeTableViewCell.swift
//  Starter
//
//  Created by Sai Xtun on 24/01/2021.
//

import UIKit

class MovieShowTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var viewForBackground: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewForBackground.layer.cornerRadius = 10
//        self.viewForBackground.layer.maskedCorners = [.]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
