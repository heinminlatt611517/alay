//
//  RatingControl.swift
//  Starter
//
//  Created by Sai Xtun on 24/01/2021.
//

import UIKit
import Foundation

@IBDesignable
class RatingControl: UIStackView {

    var ratingButtons = [UIButton]()
    
    @IBInspectable var rating : Int = 3 {
        didSet {
            self.updateButtonRating()
        }
        
    }
    @IBInspectable var starSize : CGSize = CGSize(width: 50, height: 50){
        didSet {
            self.setUpButtons()
            self.updateButtonRating()
        }
        
    }
    @IBInspectable var starCount : Int = 5{
        didSet {
            self.setUpButtons()
            self.updateButtonRating()
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpButtons()
        self.updateButtonRating()

    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpButtons()
        self.updateButtonRating()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setUpButtons() {
        self.clearExistingButton()
        
        for _ in 0..<starCount {
            let button = UIButton()
            
            button.setImage(UIImage(named: "filledStar"), for: .selected)
            button.setImage(UIImage(named: "emptyStar"), for: .normal)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            button.isUserInteractionEnabled = false
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        
    }
    
    private func updateButtonRating() {
        for(index,button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    private func clearExistingButton() {
        for button in self.ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
            
        }
        ratingButtons.removeAll()
    }
}
