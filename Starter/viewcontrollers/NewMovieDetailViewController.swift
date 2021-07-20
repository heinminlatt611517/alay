//
//  NewMovieDetailViewController.swift
//  Starter
//
//  Created by Sai Xtun on 24/03/2021.
//

import UIKit
import NVActivityIndicatorView
import YouTubePlayer

class NewMovieDetailViewController: UIViewController {
    
    //MARK: -> property

    @IBOutlet weak var movieTypeCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewProductionCompnay: UICollectionView!
    @IBOutlet weak var collectionViewActors: UICollectionView!
    @IBOutlet weak var collectionViewSimilarContent: UICollectionView!
    
    @IBOutlet weak var labelReleaseYear: UILabel!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelMovieDescription: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var viewRatingCount: RatingControl!
    @IBOutlet weak var labelVoteCount: UILabel!

    @IBOutlet weak var labelAboutMovieTitle: UILabel!
    @IBOutlet weak var labelAboutMovieDescription: UILabel!

    @IBOutlet weak var labelGenreCollectionString: UILabel!
    @IBOutlet weak var labelProductionCountries: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var buttonPlayTrailer: UIButton!

    @IBOutlet weak var actorView: UIView!
    @IBOutlet weak var productionView: UIView!
    @IBOutlet weak var similarView: UIView!
    
    private let networkAgent = MovieDBNetworkAgent.shared
    
    var movieId: Int = -1
    var movieType: MovieType?
    
    let loading = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: .blue, padding: 0)
    
    var productionCompanyData = [ProductionCompany]()
    private var casts = [MovieCast]()
    
    private var genres = [MovieGenre]()
    private var similarMoiveList = [SimilarMovieResult]()
    private var movieTrailer = [MovieTrailer]()
    
    var objects = Array.init(repeating: "hello", count: 10000000)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonPlayTrailer.isHidden = true
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        registerCollectionView()

        switch movieType {
        case .MOVIE_POPULAR:
            self.fetchMovieDetail(id: movieId)
        case .MOVIE_SERIES:
            self.fetchSeriesDetail(id: movieId)
        case .SEARCH_MOVIE:
            self.fetchMovieDetail(id: movieId)
        default:
            break
        }
        
        self.fetchMovieCredit(id: self.movieId)
        self.fetchSimilarMovieList(id: movieId)
        self.fetchMovieTariler(id: movieId)
    }
        
   //MARK: ->  init view
    private func registerCollectionView() {
        self.collectionViewActors.delegate = self
        self.collectionViewActors.dataSource = self
        self.collectionViewActors.registerForCell(identifier: BestActorCollectionViewCell.identifier)

        self.collectionViewSimilarContent.delegate = self
        self.collectionViewSimilarContent.dataSource = self
        self.collectionViewSimilarContent.registerForCell(identifier: PopularFlimCollectionViewCell.identifier)
        
        self.movieTypeCollectionView.delegate = self
        self.movieTypeCollectionView.dataSource = self
        self.movieTypeCollectionView.registerForCell(identifier: MovieTypeCollectionViewCell.identifier)
        
        self.collectionViewProductionCompnay.delegate = self
        self.collectionViewProductionCompnay.dataSource = self
        self.collectionViewProductionCompnay.registerForCell(identifier: ProductionCompanyCollectionViewCell.identifier)
        self.collectionViewProductionCompnay.showsHorizontalScrollIndicator = false
    }
    
    //MARK: -> api call
    
    //fetch movie trailer
    private func fetchMovieTariler(id: Int){
        networkAgent.getMovieTariler(id: id) { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.movieTrailer = data.results ?? []
                self.buttonPlayTrailer.isHidden = self.movieTrailer.isEmpty
            case .fail(let error):
                print(error)
            }
            
            
        }
    }
    
    //fetch populat detail data
    private func fetchMovieDetail(id: Int) {
        self.showLoading()

        networkAgent.getMovieDetailList(id: id) { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.bindData(data: data)
                self.productionCompanyData = data.productionCompanies ?? []

                self.genres = data.genres ?? []
                self.productionView.isHidden = self.productionCompanyData.isEmpty

                self.movieTypeCollectionView.reloadData()
                self.collectionViewProductionCompnay.reloadData()
            case .fail(let error):
                print(error)
            }
            
        }
    }
    
    //fetch popular detail data
    private func fetchSeriesDetail(id: Int) {
        self.showLoading()

        networkAgent.getSeriesDetailList(id: id) { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.bindSeriesData(data: data)
                self.productionCompanyData = data.productionCompanies ?? []
                self.productionView.isHidden = self.productionCompanyData.isEmpty
                self.collectionViewProductionCompnay.reloadData()
                
                self.hideloading()
            case .fail(let error):
                print(error)
            }
            
        }
    }
    
    //fetch movie credit
    private func fetchMovieCredit(id: Int) {
        self.showLoading()
        networkAgent.getMovieCreditById(id: id) { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.casts = data.cast ?? []
                
                if self.casts.count == 0 {
                    self.actorView.isHidden = true
                }else {
                    self.actorView.isHidden = false
                }
                
                self.collectionViewActors.reloadData()
                self.hideloading()
            case .fail(let error):
                print(error)
            }
            
        }

    }
  
    //fetch similar content movie
    private func fetchSimilarMovieList(id: Int) {
        networkAgent.getSimilarMovieList(id: id) { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.hideloading()
                self.similarMoiveList = data.results ?? []
                
                self.similarView.isHidden = self.similarMoiveList.count == 0
                
                self.collectionViewSimilarContent.reloadData()
            case .fail(let error):
                print(error)
            }
            
        }

    }
    
    //play trailer
    @IBAction func onClickPlayTrailer(_ sender: Any) {
        let item = movieTrailer.first
        let youtubeKey = item?.key
        
        let playerVc = YoutubePlayerViewController()
        playerVc.youtubeKey = youtubeKey
        playerVc.modalPresentationStyle = .fullScreen
        self.present(playerVc, animated: true, completion: nil)
        
    }
  
    //bind data
    private func bindData(data: MovieDetailResopnse) {

        let path = "\(Constants.baseImageUrl)\(data.backdropPath ?? "")"
        self.posterImageView.sd_setImage(with: URL(string: path), placeholderImage: nil, options: .continueInBackground, context: nil)
        
        labelReleaseYear.text = String(data.releaseDate?.split(separator: "-")[0] ?? "")
        labelMovieTitle.text = data.originalTitle
        labelMovieDescription.text = data.overview
        let hour = Int((data.runtime ?? 0) % 60)
        let minute = (data.runtime ?? 0) - hour
        labelDuration.text = "\(hour) hr \(minute)"
        labelRating.text = "\(data.voteAverage ?? 0.0)"
//        viewRatingCount
        labelVoteCount.text = "\(data.voteCount ?? 0) votes"

        viewRatingCount.rating = Int(data.voteAverage ?? 0.0 * 0.5)
        
        labelAboutMovieTitle.text = data.originalTitle
        
        var genreListString = ""
        data.genres?.forEach({ (item) in
            genreListString += item.name ?? ""
        })
        labelGenreCollectionString.text = genreListString
//        labelGenreCollectionString.text = data.genres?.map {
//            $0.name
//        }.reduce("") {"\($0 ?? ""), \($1 ?? "")"}
        
        var countrylistStr = ""
        data.productionCountries?.forEach({ (item) in
            countrylistStr += item.name ?? ""
        })
        
        labelProductionCountries.text = countrylistStr
        labelAboutMovieDescription.text = data.overview
        labelReleaseDate.text = data.releaseDate ?? ""
               
        self.navigationItem.title = data.title

        self.hideloading()
    }
    
    //bind data
    private func bindSeriesData(data: SeriesDetailResopnse) {

        let path = "\(Constants.baseImageUrl)\(data.backdropPath ?? "")"
        self.posterImageView.sd_setImage(with: URL(string: path), placeholderImage: nil, options: .continueInBackground, context: nil)
        
        labelReleaseYear.text = String(data.lastAirDate?.split(separator: "-")[0] ?? "")
        labelMovieTitle.text = data.originalName
        labelMovieDescription.text = data.overview
        
        if data.episodeRunTime?.count == 0 {
            //no data
        }else {
            let hour = Int((data.episodeRunTime?[0] ?? 0) % 60)
            let minute = (data.episodeRunTime?[0] ?? 0) - hour
            labelDuration.text = "\(hour) hr \(minute)"
        }
        labelRating.text = "\(data.voteAverage ?? 0.0)"

//        viewRatingCount
        labelVoteCount.text = "\(data.voteCount ?? 0) votes"

        viewRatingCount.rating = Int(data.voteAverage ?? 0.0 * 0.5)
        
        labelAboutMovieTitle.text = data.originalName
        
        var genreListString = ""
        data.genres?.forEach({ (item) in
            genreListString += item.name ?? ""
        })
        labelGenreCollectionString.text = genreListString
//        labelGenreCollectionString.text = data.genres?.map {
//            $0.name
//        }.reduce("") {"\($0 ?? ""), \($1 ?? "")"}
        
        var countrylistStr = ""
        data.productionCountries?.forEach({ (item) in
            countrylistStr += item.name ?? ""
        })
        
        labelProductionCountries.text = countrylistStr
        labelAboutMovieDescription.text = data.overview
        labelReleaseDate.text = data.lastAirDate ?? ""
        
        self.navigationItem.title = data.originalName
        
        self.hideloading()
    }
        
   
}

//MARK:-> extension

extension NewMovieDetailViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == movieTypeCollectionView {
            return self.genres.count
        }else if collectionView == collectionViewActors{
            return self.casts.count
        }else if collectionView == collectionViewProductionCompnay {
            return self.productionCompanyData.count
        }else {
            return self.similarMoiveList.count
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewActors {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BestActorCollectionViewCell.self), for: indexPath)as? BestActorCollectionViewCell else {
                return UICollectionViewCell()
        }
            let item = self.casts[indexPath.row]
            cell.data = item.convertToActorInfoResponse()
        return cell
            
        }else if collectionView == collectionViewSimilarContent {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PopularFlimCollectionViewCell.self), for: indexPath)as? PopularFlimCollectionViewCell else {
                return UICollectionViewCell()
        }
            
            let item = self.similarMoiveList[indexPath.row]
            cell.data = item.convertedToSimilarMovieInfo()
        return cell
        }else if collectionView == movieTypeCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieTypeCollectionViewCell.self), for: indexPath)as? MovieTypeCollectionViewCell else {
                return UICollectionViewCell()
        }
            cell.labelMovieType.text = genres[indexPath.row].name
            return cell
        
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductionCompanyCollectionViewCell.self), for: indexPath)as? ProductionCompanyCollectionViewCell else {
    
                return UICollectionViewCell()
        }
            cell.data = self.productionCompanyData[indexPath.row]
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewSimilarContent {
            navigateToNewMovieDetailViewcontroller(id: self.similarMoiveList[indexPath.row].id ?? 0, movieType: .MOVIE_POPULAR)
            
        }else if collectionView == collectionViewActors {

            let vc = ActorDetailViewController()
            vc.id = self.casts[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == movieTypeCollectionView {
            return CGSize(width: self.widthForString(text: self.genres[indexPath.row].name ?? "", font: UIFont(name: "Geeza Pro", size: 14) ?? UIFont.systemFont(ofSize: 14)) + 20, height: 30.0)
        }else if collectionView == collectionViewSimilarContent {
            return CGSize(width: 150, height: collectionViewSimilarContent.frame.height)
        }else if collectionView == collectionViewProductionCompnay {
            return CGSize(width: 110, height: collectionView.frame.height - 20)
        }
        else {
            return CGSize(width: collectionView.frame.width / 2.8, height: 200)

        }
    }
    
    func widthForString(text: String,font: UIFont) -> CGFloat {
        let fontAttribute = [NSAttributedString.Key.font : font]
        let textSize = text.size(withAttributes: fontAttribute)
        return textSize.width
    }

}

extension NewMovieDetailViewController {

    func showLoading() {
        self.view.isUserInteractionEnabled = false
        loading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loading)
        NSLayoutConstraint.activate([
            loading.widthAnchor.constraint(equalToConstant: 40),
            loading.heightAnchor.constraint(equalToConstant: 40),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        
        loading.startAnimating()
    }

    func hideloading() {
        loading.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
}
