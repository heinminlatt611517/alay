//
//  MovieDetailViewController.swift
//  Starter
//
//  Created by Sai Xtun on 23/01/2021.
//

import UIKit


class MovieDetailViewController: UIViewController {

    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var toolbarView: UIView!
    @IBOutlet weak var movieDetailTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewHeight.constant = 255 + 550
        self.mainScrollView.delegate = self
        self.setUpTableView()
    }
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setUpTableView() {
        self.movieDetailTableView.isScrollEnabled = false
        self.movieDetailTableView.delegate = self
        self.movieDetailTableView.dataSource = self
        self.movieDetailTableView.tableFooterView = UIView()
        
        self.movieDetailTableView.register(UINib(nibName: String(describing: MovieDetailTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieDetailTableViewCell.self))
        self.movieDetailTableView.register(UINib(nibName: String(describing: AboutFlimTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AboutFlimTableViewCell.self))
        self.movieDetailTableView.register(UINib(nibName: String(describing: CreaterTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CreaterTableViewCell.self))

    }

}

extension MovieDetailViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieDetailTableViewCell.self), for: indexPath)as? MovieDetailTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AboutFlimTableViewCell.self), for: indexPath)as? AboutFlimTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CreaterTableViewCell.self), for: indexPath)as? CreaterTableViewCell else {
                return UITableViewCell()
            }
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 255
        case 1:
            return 310
        case 2:
            return 250
        default:
            return 0
        }
    }
    
}

extension MovieDetailViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.bounds.minY == -44.0 || scrollView.bounds.minY < -44.0 || scrollView.bounds.minY == -20.0 || scrollView.bounds.minY < -20.0 {
            UIView.transition(with: self.toolbarView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.toolbarView.backgroundColor = UIColor.clear

            }, completion: nil)
        }else {
            UIView.transition(with: self.toolbarView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.toolbarView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
                self.toolbarView.isOpaque = false
                
            }, completion: nil)
        }
    }
}
