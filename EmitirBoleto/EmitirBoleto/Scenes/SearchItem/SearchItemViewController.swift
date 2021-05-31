//
//  SearchItemViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 21/05/21.
//

import UIKit

protocol SearchItemDelegate: AnyObject {
    
    func didSelectItem(_ item: ItemModel)
}

class SearchItemViewController: UIViewController {
    
    // MARK: Outlets
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(ItemTableViewCell.nib(), forCellReuseIdentifier: ItemTableViewCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    // MARK: Member variables
    
    weak var coordinator: MainCoordinator?
    weak var delegate: SearchItemDelegate?
    private var viewModel = SearchItemViewModel()
    private var items: [ItemModel] = []
    private var filteredItems: [ItemModel] = []
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async { [weak self] in
            self?.items = self?.viewModel.getAllItems() ?? []
            self?.filteredItems = self?.items ?? []
            self?.tableView.reloadData()
        }
    }
}

extension SearchItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier) as! ItemTableViewCell
        let item = filteredItems[indexPath.row]
        cell.prepare(with: item)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = filteredItems[indexPath.row]
        delegate?.didSelectItem(item)
        coordinator?.dismiss()
    }
}

extension SearchItemViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredItems = searchText.isEmpty ? items : items.filter { (item: ItemModel) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
                
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

