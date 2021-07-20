//
//  Router.swift
//  Starter
//
//  Created by Sai Xtun on 20/03/2021.
//

import Foundation
import UIKit

enum StoryBoardName: String {
    case Main = "Main"
}

extension UIStoryboard {
   static func mainStoryBoard()-> UIStoryboard {
        UIStoryboard(name: StoryBoardName.Main.rawValue, bundle: nil)
    }
}

extension UIViewController {
    func navigateToMovieDetailViewController() {
//        let viewcontroller = self.storyboard?.instantiateViewController(withIdentifier: MovieDetailViewController.identifier) as! MovieDetailViewController
//        self.navigationController?.pushViewController(viewcontroller, animated: true)
        
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MovieDetailViewController.identifier)as? MovieDetailViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func navigateToNewMovieDetailViewcontroller(id: Int,movieType: MovieType) {
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: NewMovieDetailViewController.identifier)as? NewMovieDetailViewController else {
            return
        }
        vc.modalPresentationStyle = .overFullScreen
        vc.movieId = id
        vc.movieType = movieType
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
