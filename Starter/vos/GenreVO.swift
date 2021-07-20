//
//  GenreVO.swift
//  Starter
//
//  Created by Sai Xtun on 30/01/2021.
//

import Foundation

class GenreVO {
    var name : String = "Action"
    var isSelected : Bool = false
    var id: Int = 0
    
    init(name: String,isSelected: Bool,id : Int) {
        self.name = name
        self.isSelected = isSelected
        self.id = id
    }
}
