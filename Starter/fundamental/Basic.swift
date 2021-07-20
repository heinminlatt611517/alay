//
//  Basic.swift
//  Starter
//
//  Created by Sai Xtun on 23/01/2021.
//

import Foundation

var colorList = ["red","green"]
var regionList : Set = ["Yangon, Mandalay"]
var townshipList : [String: [String]]  = ["Yangon": ["Hlaing","Kamayut"]]

// global closure
var doOnNext: ((String)-> String)? = {_ ->String in ""}

//neseted function
func makeIncrease(amount: Int) ->()-> Int {
    var total = 0
    
    func totalIncrease() -> Int {
        total += amount
        return total
    }
    
    return totalIncrease
}

//trailing closure
func trailClosure(total:Int, trail:() -> Void) -> Void {
    debugPrint("trailing closure")
}


//main
public func main() {
        
    let townships = townshipList["Yangon"]
    
    debugPrint(townships)
    
    for color in colorList {
        debugPrint(color)
    }
    
    var indexForWhile = 0
    while indexForWhile < colorList.count {
        debugPrint(colorList[indexForWhile])
        indexForWhile += 1
    }
    
    var indexForRepeatWhile = 0
    repeat {
        debugPrint(colorList[indexForRepeatWhile])
        indexForRepeatWhile += 1
    }while indexForRepeatWhile < colorList.count
    
    
    //global closure
    doOnNext = {name -> String in
        debugPrint(name)
        
        return name
    }
    
   
}
