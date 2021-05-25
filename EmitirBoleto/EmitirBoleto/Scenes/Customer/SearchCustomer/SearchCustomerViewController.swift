//
//  SearchCustomerViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 20/05/21.
//

import UIKit

class SearchCustomerViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(CustomersTableViewCell.nib(), forCellReuseIdentifier: CustomersTableViewCell.identifier)
            tableView.dataSource = self
        }
    }
    
    var customers: [CustomerModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

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
}
