//
//  ShowCaseTableViewCell.swift
//  Starter
//
//  Created by Sai Xtun on 24/01/2021.
//

import UIKit

class ShowCaseTableViewCell: UITableViewCell {

    @IBOutlet weak var showCaseCollectionView: UICollectionView!
    
   weak var delegate: movieCellDelegate?
   weak var moreShowCaseDelegate: MoreShowCaseDelegate?
    
    var data: MovieListResponse? {
        didSet {
            if let _ = data {
                self.showCaseCollectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUpCollectionView()
    }
    
    //setup collectionview
    func setUpCollectionView() {
        self.showCaseCollectionView.delegate = self
        self.showCaseCollectionView.dataSource = self
        self.showCaseCollectionView.showsHorizontalScrollIndicator = true
        
        self.showCaseCollectionView.registerForCell(identifier: ShowCaseCollectionViewCell.identifier)
        
       
    }

    @IBAction func onclickMoreShowCase(_ sender: Any) {
        moreShowCaseDelegate?.onTapMoreShowCase()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension ShowCaseTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeCell(identifier: ShowCaseCollectionViewCell.identifier, indexPath: indexPath) as! ShowCaseCollectionViewCell
        cell.showCaseData = self.data?.results?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 60, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.userDidTap(id: self.data?.results?[indexPath.row].id ?? 0, movieType: MovieType.MOVIE_POPULAR)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        (scrollView.subviews[(scrollView.subviews.count - 1)]).backgroundColor = .yellow
    }
    
}
