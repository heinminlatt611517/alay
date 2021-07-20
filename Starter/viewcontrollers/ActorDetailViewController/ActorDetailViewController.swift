//
//  ActorDetailViewController.swift
//  Starter
//
//  Created by Admin on 10/07/2021.
//

import UIKit

class ActorDetailViewController: UIViewController {
    
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelMovieDescription: UILabel!
    
    @IBOutlet weak var labelAboutMovieTitle: UILabel!
    @IBOutlet weak var labelAboutMovieDescription: UILabel!

    @IBOutlet weak var labelGenreCollectionString: UILabel!
    @IBOutlet weak var labelProductionCountries: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    

    @IBOutlet weak var productionView: UIView!

    private let networkAgent = MovieDBNetworkAgent.shared

    var id: Int = -1
    
    override func viewDidLoad() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        super.viewDidLoad()

        self.fetchActorDetail(id: id)
        
        // Do any additional setup after loading the view.
    }

    
    //fetch actor detail
    private func fetchActorDetail(id: Int) {
        networkAgent.getActorDetailById(id: id) { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.bindActorDetailData(data: data)
            case .fail(let error):
                print(error)
            }
            
        }
    }
    
    //MARK:-> bind actor detail data
    private func bindActorDetailData(data: ActorDetailResopnse) {
        
        
        let path = "\(Constants.baseImageUrl)\(data.profilePath ?? "")"
        self.posterImageView.sd_setImage(with: URL(string: path), placeholderImage: nil, options: .continueInBackground, context: nil)
        
        labelMovieTitle.text = data.name
        labelMovieDescription.text = data.biography
        
//        viewRatingCount

        labelAboutMovieTitle.text = data.name
        
        var genreListString = ""
        data.alsoKnownAs?.forEach({ (item) in
            genreListString += item
        })
        labelGenreCollectionString.text = genreListString

        let countrylistStr = data.placeOfBirth
        
        labelProductionCountries.text = countrylistStr
        labelAboutMovieDescription.text = data.biography
        
        self.navigationItem.title = data.name
       
    }
    

}
