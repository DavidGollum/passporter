//
//  ListPlacesViewController.swift
//  passporter
//
//  Created by dgonzbal on 10/5/22.
//

import Foundation
import UIKit

protocol ListPlacesViewControllerProtocol {
    func setInfo(data: [PlaceModel]?)
    func navigateTo(view: UIViewController)
}

class ListPlacesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var dataSource: [PlaceModel]?
    private var viewModel: ListPlacesVMtoViewProtocol?
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        viewModel = ListPlacesViewModel(view: self)
        viewModel?.start()
    }
}

// MARK: UITableViewDelegate
extension ListPlacesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
                as? ItemCell else {
            return UITableViewCell()
        }
        cell.configure(item: dataSource?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.select(item: dataSource?[indexPath.row])
    }
}

// MARK: UISearchBarDelegate
extension ListPlacesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.search(text: searchText)
    }
}

// MARK: ListPlacesViewControllerProtocol
extension ListPlacesViewController: ListPlacesViewControllerProtocol {
    func navigateTo(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
    
    func setInfo(data: [PlaceModel]?) {
        dataSource = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
