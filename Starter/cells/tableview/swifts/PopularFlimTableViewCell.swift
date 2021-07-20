//
//  PopularFlimTableViewCell.swift
//  Starter
//
//  Created by Sai Xtun on 24/01/2021.
//

import UIKit

class PopularFlimTableViewCell: UITableViewCell {

    @IBOutlet weak var popularFlimCollectionView: UICollectionView!
    @IBOutlet weak var labelTitle: UILabel!
    
    var delegate : movieCellDelegate?
    
    var movieType: MovieType?
    
    var data: MovieListResponse? {
        didSet {
            if let data = data {
                popularFlimCollectionView.reloadData()

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
        self.popularFlimCollectionView.delegate = self
        self.popularFlimCollectionView.dataSource = self
        self.popularFlimCollectionView.showsHorizontalScrollIndicator = false
        
        self.popularFlimCollectionView.registerForCell(identifier: PopularFlimCollectionViewCell.identifier)
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension PopularFlimTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeCell(identifier: PopularFlimCollectionViewCell.identifier, indexPath: indexPath) as! PopularFlimCollectionViewCell
        cell.data = data?.results?[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.userDidTap(id: self.data?.results?[indexPath.row].id ?? 0, movieType: movieType!)
    }
    
    
}

