//
//  MovieViewController.swift
//  Starter
//
//  Created by Sai Xtun on 24/01/2021.
//

import UIKit

protocol movieCellDelegate: class {
    func userDidTap(id: Int,movieType: MovieType)
}

class MovieViewController: UIViewController {
    @IBOutlet weak var tableViewMovies: UITableView!
    
    var delegate: movieCellDelegate?
    private let networkAgent = MovieDBNetworkAgent.shared
    
    private var upcomingMovieList : MovieListResponse?
    private var popularMovieList : MovieListResponse?
    private var popularSeriesList : MovieListResponse?
    private var genreMovieList: GenreMovieLists?
    private var showcaseMovieList: MovieListResponse?
    private var actorList: ActorListResopnse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpTableView()
        self.fecthUpcomingMovieData()
        self.fecthPopularMovieData()
        self.fecthPopularSeriesData()
        self.fetchGenreMovieList()
        self.fetchShowCaseMovieList()
        self.fetchActorList()
       
    }

    
    func setUpTableView() {
        self.tableViewMovies.tableFooterView = UIView()
        self.tableViewMovies.delegate = self
        self.tableViewMovies.dataSource = self
        self.tableViewMovies.separatorStyle = .none

        self.tableViewMovies.registerForCell(identifier: MovieSliderTableViewCell.identifier)
        self.tableViewMovies.registerForCell(identifier: PopularFlimTableViewCell.identifier)
        self.tableViewMovies.registerForCell(identifier: MovieShowTimeTableViewCell.identifier)
        self.tableViewMovies.registerForCell(identifier: MovieTypeTableViewCell.identifier)
        self.tableViewMovies.registerForCell(identifier: ShowCaseTableViewCell.identifier)
        self.tableViewMovies.registerForCell(identifier: BestActorTableViewCell.identifier)

    }
    
    //fetching data
    private func fecthUpcomingMovieData() {
        networkAgent.getUpcomintMovieList { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.upcomingMovieList = data
                self.tableViewMovies.reloadSections(IndexSet(integer: 0), with: .automatic)
            case .fail(let error):
                print(error)
            }
            
        }
    }
    
    //fetch popular movie list
    private func fecthPopularMovieData() {
        networkAgent.getPopularMovieList { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.popularMovieList = data
                self.tableViewMovies.reloadSections(IndexSet(integer: 1), with: .automatic)
            case .fail(let error):
                print(error)
            }
            
        }

    }
    
    //fetch popular series list
    private func fecthPopularSeriesData() {
        networkAgent.getPopularSeriesList { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.popularSeriesList = data
                self.tableViewMovies.reloadSections(IndexSet(integer: 2), with: .automatic)
            case .fail(let error):
                print(error)
            }
            

        }

    }
    
    //fetch genre movie
    private func fetchGenreMovieList() {
        networkAgent.getGenreList { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.genreMovieList = data
                self.tableViewMovies.reloadSections(IndexSet(integer: 4), with: .automatic)
                
            case .fail(let message):
                print(message)
            }
        }
    }
    
    //toprated movie list
    private func fetchShowCaseMovieList() {
        networkAgent.getTopRatedMovieList { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.showcaseMovieList = data
                self.tableViewMovies.reloadSections(IndexSet(integer: 5), with: .automatic)
            case .fail(let error):
                print(error)
            }
            
        }

    }
    
    //fetch actor list
    private func fetchActorList() {
        networkAgent.getActorList { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.actorList = data
                self.tableViewMovies.reloadSections(IndexSet(integer: 6), with: .automatic)
            case .fail(let error):
                print(error)
            }
            
        }

    }
    
    
    @IBAction func onclickSearch(_ sender: UIBarButtonItem) {
        let vc = SearchViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

extension MovieViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case MovieType.MOVIE_SLIDER.rawValue:
            let cell = tableView.dequeueCell(identifier: MovieSliderTableViewCell.identifier, indexPath: indexPath) as! MovieSliderTableViewCell
            cell.delegate = self
            cell.data = upcomingMovieList
            return cell
            
        case MovieType.MOVIE_POPULAR.rawValue:
            let cell = tableView.dequeueCell(identifier: PopularFlimTableViewCell.identifier, indexPath: indexPath)as! PopularFlimTableViewCell
            cell.labelTitle.text = "BEST POPULAR FLIMS"
            cell.data = popularMovieList
            cell.delegate = self
            cell.movieType = MovieType.MOVIE_POPULAR

            return cell
            
        case MovieType.MOVIE_SERIES.rawValue:
            let cell = tableView.dequeueCell(identifier: PopularFlimTableViewCell.identifier, indexPath: indexPath)as! PopularFlimTableViewCell
            cell.labelTitle.text = "BEST POPULAR SERIES"
            cell.data = popularSeriesList
            cell.delegate = self
            cell.movieType = MovieType.MOVIE_SERIES
            return cell
            
        case MovieType.MOVIE_SHOWTIE.rawValue:
            return tableView.dequeueCell(identifier: MovieShowTimeTableViewCell.identifier, indexPath: indexPath)
            
        case MovieType.MOVIE_GENRE.rawValue:
            let cell = tableView.dequeueCell(identifier: MovieTypeTableViewCell.identifier, indexPath: indexPath) as! MovieTypeTableViewCell
            
            var movieList: [MovieResult] = []
            movieList.append(contentsOf: upcomingMovieList?.results ?? [MovieResult]())
            movieList.append(contentsOf: popularMovieList?.results ?? [MovieResult]())
            movieList.append(contentsOf: popularSeriesList?.results ?? [MovieResult]())
            cell.allMovieAndSeries = movieList
            
            let resultData: [GenreVO]? = self.genreMovieList?.genres?.map{ movieGenre -> GenreVO in
               return movieGenre.convertToGenreVO()
            }
            resultData?.first?.isSelected = true
            cell.genreList = resultData
            
            cell.delegate = self
            
            return cell
            
        case MovieType.MOVIE_SHOWCASE.rawValue:
            let cell = tableView.dequeueCell(identifier: ShowCaseTableViewCell.identifier, indexPath: indexPath) as! ShowCaseTableViewCell
            cell.delegate = self
            cell.moreShowCaseDelegate = self
            cell.data = self.showcaseMovieList
            return cell
            
        case MovieType.MOVIE_BESTACTOR.rawValue:
            let cell = tableView.dequeueCell(identifier: BestActorTableViewCell.identifier, indexPath: indexPath)as! BestActorTableViewCell
            cell.delegate = self
            cell.data = self.actorList
            cell.moreActorDelegate = self
            
            return cell
        default:
            return UITableViewCell()
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 220
        case 1:
            return 320
        case 2:
            return 320
        case 3:
            return 160
        case 4:
            return 340
        case 5:
            return 240
        case 6:
            return 285
        default:
            return 0
        }
    }
    

}

extension MovieViewController: movieCellDelegate,MovieItemDelegate,MoreActorDelegate,MoreShowCaseDelegate,ActorDetailDelegate {
    func onTapActorItem(id: Int) {
        let vc = ActorDetailViewController()
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func onTapMoreShowCase() {
        let vc = MoreShowCaseViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func onTapMoreActor() {
        let vc = MoreActorViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func userDidTap(id: Int,movieType: MovieType) {
        self.navigateToNewMovieDetailViewcontroller(id: id, movieType: movieType)
        print("id....\(id)")
    }
    
    func onTapItem(movieId: Int) {
//        self.navigateToNewMovieDetailViewcontroller(id: movieId, movieType: nil)
        print("id is....\(movieId)")
    }
  
    
}
