//
//  TypeCollectionViewCell.swift
//  Starter
//
//  Created by Sai Xtun on 24/01/2021.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var selectedView: UIView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelMovieName: UILabel!
    
    var onTapItem : ((Int)-> Void) = {_ in}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedView.backgroundColor = .yellow
        
        let tapGestureForContainer = UITapGestureRecognizer(target: self, action: #selector(tapContainer))
        self.containerView.isUserInteractionEnabled = true
        self.containerView.addGestureRecognizer(tapGestureForContainer)
        
    }
    
    @objc func tapContainer() {
        onTapItem(data?.id ?? 0)
    }
    
    var data: GenreVO? = nil {
        didSet {
            
            if let genre = data {
                self.labelMovieName.text = genre.name.uppercased()
                (genre.isSelected ) ? (selectedView.isHidden = false) : (selectedView.isHidden = true)
                (genre.isSelected ) ? (self.labelMovieName.textColor = .white) : (self.labelMovieName.textColor = .gray)

            }
            
            
        }
    }

    func didSet(data: GenreVO) {
        self.data = data
    }
    
}
