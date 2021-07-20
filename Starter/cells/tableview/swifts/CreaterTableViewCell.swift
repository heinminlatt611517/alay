//
//  CreaterTableViewCell.swift
//  Starter
//
//  Created by Sai Xtun on 25/01/2021.
//

import UIKit

class CreaterTableViewCell: UITableViewCell {

    @IBOutlet weak var creatorCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUpCollectionView()
    }

    //setup collectionview
    func setUpCollectionView() {
        self.creatorCollectionView.delegate = self
        self.creatorCollectionView.dataSource = self
        self.creatorCollectionView.showsHorizontalScrollIndicator = false
        
        self.creatorCollectionView.register(UINib(nibName: String(describing: BestActorCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: BestActorCollectionViewCell.self))
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CreaterTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
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
