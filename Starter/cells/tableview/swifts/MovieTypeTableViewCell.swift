//
//  MovieTypeTableViewCell.swift
//  Starter
//
//  Created by Sai Xtun on 24/01/2021.
//

import UIKit

class MovieTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var typeCollectionView: UICollectionView!
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var delegate: movieCellDelegate?
    var genreFirstId: Int = 0
    
//    var genreList = [GenreVO(name: "ACTION", isSelected: true),GenreVO(name: "ADVANTURE", isSelected: false),GenreVO(name: "CRIMINAL", isSelected: false),GenreVO(name: "DRAMA", isSelected: false),GenreVO(name: "COMEDY", isSelected: false)]
    var genreList : [GenreVO]? {
        didSet {
            if let _ = genreList {
                self.typeCollectionView.reloadData()
                genreList?.removeAll(where: { (genrevo) -> Bool in
                    let id = genrevo.id
                    
                    let result = movieListByGenre.filter { (key,value) -> Bool in
                        id == key
                    }
                    
                   return result.count == 0
                    
                })
            }
            self.onTapItem(generId: genreList?.first?.id ?? 0)

        }
    }
    
    var allMovieAndSeries: [MovieResult] = [] {
        didSet {
            allMovieAndSeries.forEach { (movieSeries) in
                movieSeries.genreIDS?.forEach({ (genreId) in
                    let key = genreId
                    
                    if var _ = movieListByGenre[key] {
                        self.movieListByGenre[key]?.insert(movieSeries)
                    }else {
                        movieListByGenre[key] = [movieSeries]
                    }
                })
            }

        }
    }
    
    var SelectmovieList = [MovieResult]()
    var movieListByGenre = [Int: Set<MovieResult>]()
    
    var movieList = [MovieResult]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUpCollectionView()
    }
    
    //setup collectionview
    func setUpCollectionView() {
        self.typeCollectionView.delegate = self
        self.typeCollectionView.dataSource = self
        self.typeCollectionView.showsHorizontalScrollIndicator = false
        
        
        self.typeCollectionView.registerForCell(identifier: TypeCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        self.typeCollectionView.setCollectionViewLayout(layout, animated: true, completion: nil)
        
        self.movieCollectionView.delegate = self
        self.movieCollectionView.dataSource = self
        self.movieCollectionView.showsHorizontalScrollIndicator = false
        
        self.movieCollectionView.registerForCell(identifier: PopularFlimCollectionViewCell.identifier)
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MovieTypeTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.typeCollectionView {
            return self.genreList?.count ?? 0

        }else {
            return self.SelectmovieList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.typeCollectionView {
            let cell = collectionView.dequeCell(identifier: TypeCollectionViewCell.identifier, indexPath: indexPath)as! TypeCollectionViewCell
            
            cell.data = self.genreList?[indexPath.row]
            cell.onTapItem = {generId in
                self.onTapItem(generId: generId)
            }
            
            return cell
        }else {
            let cell = collectionView.dequeCell(identifier: PopularFlimCollectionViewCell.identifier, indexPath: indexPath) as! PopularFlimCollectionViewCell
            cell.data = self.SelectmovieList[indexPath.row]
            return cell
        }
    }
    
    private func onTapItem(generId: Int) {
        self.genreList?.forEach { (genreVo) in
            if generId == genreVo.id {
                genreVo.isSelected = true
            }else {
                genreVo.isSelected = false
            }
        }
        
        let movieList = self.movieListByGenre[generId]
        self.SelectmovieList = movieList?.map { $0 } ?? [MovieResult]()
         
        self.typeCollectionView.reloadData()
        self.movieCollectionView.reloadData()

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.userDidTap(id: self.SelectmovieList[indexPath.row].id ?? 0, movieType: MovieType.MOVIE_POPULAR)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.typeCollectionView {
            return CGSize(width: self.widthForString(text: self.genreList?[indexPath.row].name ?? "", font: UIFont(name: "Geeza Pro", size: 14) ?? UIFont.systemFont(ofSize: 14)) + 20, height: 50.0)
        }else
        {
            return  CGSize(width: 150, height: 255)
        }
    }
    
    //for spacint
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func widthForString(text: String,font: UIFont) -> CGFloat {
        let fontAttribute = [NSAttributedString.Key.font : font]
        let textSize = text.size(withAttributes: fontAttribute)
        return textSize.width
    }
    
}
