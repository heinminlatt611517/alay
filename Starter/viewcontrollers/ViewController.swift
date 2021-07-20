//
//  ViewController.swift
//  Starter
//
//  Created by Sai Xtun on 23/01/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableViewContent: UITableView!
    var network = MovieDBNetworkAgentWithUrlSession.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewContent.delegate = self
        self.tableViewContent.dataSource = self
        self.tableViewContent.register(UINib(nibName: String(describing: Sample1TableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: Sample1TableViewCell.self))
        self.tableViewContent.register(UINib(nibName: String(describing: Sample2TableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: Sample2TableViewCell.self))

        getGenre()
    }
    
    func getGenre() {
        network.getGenreList { (data) in
            print(data)
        }
    }


}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Sample1TableViewCell.self), for: indexPath) as? Sample1TableViewCell else { return UITableViewCell() }
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Sample2TableViewCell.self), for: indexPath) as? Sample2TableViewCell else { return UITableViewCell() }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
