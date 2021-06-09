//
//  SearchCustomerViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 20/05/21.
//

import UIKit

protocol SearchCustomerDelegate: AnyObject {
    
    func didSelectCustomer(_ customer: CustomerModel)
}

class SearchCustomerViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(CustomersTableViewCell.nib(), forCellReuseIdentifier: CustomersTableViewCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    
    // MARK: - Member variables
    
    weak var coordinator: MainCoordinator?
    weak var delegate: SearchCustomerDelegate?
    private let viewModel = SearchCustomerViewModel()
    private var customers: [CustomerModel] = []    
    private var filteredCustomers: [CustomerModel] = []
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async { [weak self] in
            self?.customers = self?.viewModel.getAllCustomers() ?? []
            self?.filteredCustomers = self?.customers ?? []
            self?.tableView.reloadData()
        }
    }
}


// MARK: - Delegates

extension SearchCustomerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCustomers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomersTableViewCell.identifier) as! CustomersTableViewCell
        let customer = filteredCustomers[indexPath.row]
        cell.prepare(with: customer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let customer = filteredCustomers[indexPath.row]
        delegate?.didSelectCustomer(customer)
        dismiss(animated: true)
    }
}

extension SearchCustomerViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCustomers = searchText.isEmpty ? customers : customers.filter { (customer: CustomerModel) -> Bool in
            return customer.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
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
