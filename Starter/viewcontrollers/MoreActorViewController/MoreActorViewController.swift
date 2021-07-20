//
//  MoreActorViewController.swift
//  Starter
//
//  Created by Admin on 07/07/2021.
//

import UIKit

class MoreActorViewController: UIViewController {
    @IBOutlet weak var actorCollectionView: UICollectionView!
    
    private var networkAgent = MovieDBNetworkAgent.shared
    
    private var data = [ActorResult]()

    private var totalPages: Int = 1
    private var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.title = "ACTORS"

        registerCell()
        fetchMoreActor(page: currentPage)
    }

    //register collection view
    private func registerCell(){
        actorCollectionView.delegate = self
        actorCollectionView.dataSource = self
        
        actorCollectionView.registerForCell(identifier: MoreActorCollectionViewCell.identifier)
        
    }
        
    private func fetchMoreActor(page: Int) {
        networkAgent.getPopularPeople(page: page) { (result) in
            switch result {
            case .success(let data):
                self.data.append(contentsOf: data.results ?? [])
                
                self.totalPages = data.totalPages ?? 0
                self.currentPage = data.page ?? 0
                
                self.actorCollectionView.reloadData()
            case .fail(let error):
                print(error)
            }
            
        }

    }

}

extension MoreActorViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeCell(identifier: MoreActorCollectionViewCell.identifier, indexPath: indexPath) as? MoreActorCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = self.data[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.1 - 8, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isLastRow = indexPath.row == data.count - 1
        let hasMorePage = currentPage < totalPages
        
        if isLastRow && hasMorePage {
            currentPage = currentPage + 1
                        
            fetchMoreActor(page: currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ActorDetailViewController()
        vc.id = self.data[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
