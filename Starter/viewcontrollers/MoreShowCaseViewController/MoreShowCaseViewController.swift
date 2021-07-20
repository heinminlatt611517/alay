//
//  MoreShowCaseViewController.swift
//  Starter
//
//  Created by Admin on 07/07/2021.
//

import UIKit

class MoreShowCaseViewController: UIViewController {

    @IBOutlet weak var moreShowCaseCollectionView: UICollectionView!
    
    private var networkAgent = MovieDBNetworkAgent.shared
    private var totalPages = 1
    private var currentPage = 1
    
    private var data = [MovieResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.title = "SHOWCASES"
        registerCell()
        fetchMoreShowCase(page: currentPage)
    }

    //register collection view
    private func registerCell(){
        moreShowCaseCollectionView.delegate = self
        moreShowCaseCollectionView.dataSource = self
        moreShowCaseCollectionView.registerForCell(identifier: ShowCaseCollectionViewCell.identifier)
        
    }
    
    //fetch moreshowcase
    private func fetchMoreShowCase(page: Int) {
        networkAgent.getMoreShowCaseList(page: page) { (result) in
            
            switch result {
            case .success(let data):
                self.data.append(contentsOf: data.results ?? [])
                self.currentPage = data.page ?? 1
                self.totalPages = data.totalPages ?? 1
                
                self.moreShowCaseCollectionView.reloadData()
            case .fail(let error):
                print(error)
            }
            
            
        }

    }
    
}

extension MoreShowCaseViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeCell(identifier: ShowCaseCollectionViewCell.identifier, indexPath: indexPath)as? ShowCaseCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.showCaseData = data[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 15, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isLastRow = indexPath.row == data.count - 1
        let hasMorePage = currentPage < totalPages
        
        if isLastRow && hasMorePage {
            currentPage = currentPage + 1
            
            fetchMoreShowCase(page: currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToNewMovieDetailViewcontroller(id: self.data[indexPath.row].id ?? 0, movieType: .MOVIE_POPULAR)

    }
    
    
}
