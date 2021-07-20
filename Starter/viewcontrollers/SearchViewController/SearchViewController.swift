//
//  SearchViewController.swift
//  Starter
//
//  Created by Admin on 07/07/2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchCollectionView: UICollectionView!

    private var networkAgent = MovieDBNetworkAgent.shared
    
    private var data = [MovieResult]()
    var currentpage: Int = 1
    var totalPages: Int = 1
    
    private var searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        initView()
    }
    
    private func initView() {
        searchBar.searchTextField.textColor = .white
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        self.fetchSearchMovies(page: currentpage, keyword: searchBar.text ?? "")

    }

    private func registerCell(){
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.registerForCell(identifier: PopularFlimCollectionViewCell.identifier)
        
    }
    
    //fetch searchmovie...
    private func fetchSearchMovies(page: Int,keyword: String) {
                
        networkAgent.getSearchMovie(query: keyword, page: page) { (result) in
            
            switch result {
            case .success(let data):
                self.data.append(contentsOf: data.results ?? [])
                self.totalPages = data.totalPages ?? 1
                self.searchCollectionView.reloadData()
            case .fail(let error):
                print(error)
            }
                                    
        }

    }

}

extension SearchViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeCell(identifier: PopularFlimCollectionViewCell.identifier, indexPath: indexPath)as? PopularFlimCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.data = self.data[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.1 - 8, height: 260)

    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isLastRow = indexPath.row == self.data.count - 1
        let hasMorePage = currentpage < totalPages
        
        if isLastRow && hasMorePage {
            currentpage = currentpage + 1

            self.fetchSearchMovies(page: currentpage, keyword: searchBar.text ?? "")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToNewMovieDetailViewcontroller(id: self.data[indexPath.row].id ?? 0, movieType: .SEARCH_MOVIE)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        
        if let data = searchBar.text {
            self.currentpage = 1
            self.totalPages = 1
            self.data.removeAll()
            
           
            self.fetchSearchMovies(page: currentpage, keyword: data)
            self.searchCollectionView.reloadData()
        }
        
        
    }
}
