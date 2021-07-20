//
//  MovieDetailTableViewCell.swift
//  Starter
//
//  Created by Sai Xtun on 24/01/2021.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var movieDetailCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpCollectionView()
    }
    
    //setup collectionview
    func setUpCollectionView() {
        self.movieDetailCollectionView.delegate = self
        self.movieDetailCollectionView.dataSource = self
        self.movieDetailCollectionView.showsHorizontalScrollIndicator = false
        
        self.movieDetailCollectionView.register(UINib(nibName: String(describing: BestActorCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: BestActorCollectionViewCell.self))
        
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MovieDetailTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BestActorCollectionViewCell.self), for: indexPath)as? BestActorCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
}

