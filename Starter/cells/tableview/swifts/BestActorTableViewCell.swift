//
//  BestActorTableViewCell.swift
//  Starter
//
//  Created by Sai Xtun on 24/01/2021.
//

import UIKit

class BestActorTableViewCell: UITableViewCell {
    @IBOutlet weak var bestActorCollectionView: UICollectionView!
    
    var delegate: ActorDetailDelegate?
    
    var moreActorDelegate: MoreActorDelegate?
    
    var data: ActorListResopnse? {
        didSet {
            if let _ = data {
                self.bestActorCollectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpCollectionView()
    }
    
    //setup collectionview
    func setUpCollectionView() {
        self.bestActorCollectionView.delegate = self
        self.bestActorCollectionView.dataSource = self
        self.bestActorCollectionView.showsHorizontalScrollIndicator = false
                
        self.bestActorCollectionView.registerForCell(identifier: BestActorCollectionViewCell.identifier)
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onclickMoreActor(_ sender: Any) {
        moreActorDelegate?.onTapMoreActor()
    }
    
}

extension BestActorTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(identifier: BestActorCollectionViewCell.identifier, indexPath: indexPath)as! BestActorCollectionViewCell
        cell.data = self.data?.results?[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.userDidTap(id: self.data?.results?[indexPath.row].id ?? 0, movieType: MovieType.MOVIE_BESTACTOR)
        
        delegate?.onTapActorItem(id: self.data?.results?[indexPath.row].id ?? 0)
        
    }
}

extension BestActorTableViewCell: ActorActionDelegate {
    func onTapFavourite(isFavourite: Bool) {
        print("favourite.....\(isFavourite)")
    }
    
    
}

