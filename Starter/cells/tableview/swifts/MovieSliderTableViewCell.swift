//
//  MovieSliderTableViewCell.swift
//  Starter
//
//  Created by Sai Xtun on 24/01/2021.
//

import UIKit

class MovieSliderTableViewCell: UITableViewCell {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionViewMovie: UICollectionView!
    
    var delegate: MovieItemDelegate?
    
    var imageArray = ["image4","image1","image3","image2","image5"]
    
    var data: MovieListResponse? {
        didSet {
            if let data = data {
                collectionViewMovie.reloadData()
                self.pageControl.numberOfPages = data.results?.count ?? 0

             }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUpCollectionView()
        self.pageControl.currentPageIndicatorTintColor = UIColor.yellow
    }
    
    //setup collectionview
    func setUpCollectionView() {
        self.collectionViewMovie.delegate = self
        self.collectionViewMovie.dataSource = self
        self.collectionViewMovie.isPagingEnabled = true
        self.collectionViewMovie.showsHorizontalScrollIndicator = false
        
        
        self.collectionViewMovie.registerForCell(identifier: MovieSliderCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        self.collectionViewMovie.setCollectionViewLayout(layout, animated: true, completion: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MovieSliderTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(identifier: MovieSliderCollectionViewCell.identifier, indexPath: indexPath)as! MovieSliderCollectionViewCell
                
       let celldata = data?.results?[indexPath.row]
        cell.data = celldata
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.onTapItem(movieId: data?.results?[indexPath.row].id ?? 0)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)

    }
}
