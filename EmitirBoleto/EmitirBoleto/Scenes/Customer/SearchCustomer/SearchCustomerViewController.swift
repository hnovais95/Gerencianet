//
//  SearchCustomerViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 20/05/21.
//

import UIKit

protocol SearchCustomerDelegate: AnyObject {
    
    func didSelectCustomer(customer: CustomerModel)
}

class SearchCustomerViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(CustomersTableViewCell.nib(), forCellReuseIdentifier: CustomersTableViewCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    // MARK: Member variables
    
    weak var coordinator: MainCoordinator?
    weak var delegate: SearchCustomerDelegate?
    private let viewModel = SearchCustomerViewModel()
    private var customers: [CustomerModel] = []
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async { [weak self] in
            self?.customers = self?.viewModel.getAllCustomers() ?? []
            self?.tableView.reloadData()
        }
    }
}


// MARK: Delegates

extension SearchCustomerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomersTableViewCell.identifier) as! CustomersTableViewCell
        let customer = customers[indexPath.row]
        cell.prepare(with: customer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let customer = customers[indexPath.row]
        delegate?.didSelectCustomer(customer: customer)
        coordinator?.dismiss()
    }
}
