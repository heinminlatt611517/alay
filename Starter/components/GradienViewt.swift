//
//  Gradient.swift
//  Starter
//
//  Created by Sai Xtun on 24/01/2021.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    let colorPrimary: UIColor = #colorLiteral(red: 0.02745098039, green: 0.1137254902, blue: 0.1647058824, alpha: 1)
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor.clear.cgColor,self.colorPrimary.cgColor]
        }
    }


