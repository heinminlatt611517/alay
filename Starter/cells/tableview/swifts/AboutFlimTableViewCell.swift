//
//  AboutFlimTableViewCell.swift
//  Starter
//
//  Created by Sai Xtun on 24/01/2021.
//

import UIKit

class AboutFlimTableViewCell: UITableViewCell {

    @IBOutlet weak var textViewDescription: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.textViewDescription.translatesAutoresizingMaskIntoConstraints = true
//        self.textViewDescription.sizeToFit()
//        self.textViewDescription.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
