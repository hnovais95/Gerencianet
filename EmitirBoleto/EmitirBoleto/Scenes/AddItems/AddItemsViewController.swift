//
//  AddItemsViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 24/05/21.
//

import UIKit

class AddItemsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(EmptyTableViewCell.nib(), forCellReuseIdentifier: EmptyTableViewCell.identifier)
            tableView.register(ItemDetailsTableViewCell.nib(), forCellReuseIdentifier: ItemDetailsTableViewCell.identifier)
            tableView.register(ButtonsTableViewCell.nib(), forCellReuseIdentifier: ButtonsTableViewCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var backButton: BackButton!
    @IBOutlet weak var nextButton: NextButton!
    
    
    // MARK: Member variables
    
    weak var coordinator: MainCoordinator?
    private var viewModel = AddItemsViewModel()
    
    
    // MARK: Member methods
    
    func setCustomer(_ customer: CustomerModel) {
        viewModel.customer = customer
    }
    
    
    // MARK: Life Cycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.addTarget(self, action: #selector(handleTapBackButton(_:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(handleTapNextButton(_:)), for: .touchUpInside)
    }
    
    
    // MARK: Handlers
    
    @objc
    private func handleTapBackButton(_ sender: UIButton) {
        coordinator?.back()
    }
    
    @objc
    private func handleTapNextButton(_ sender: UIButton) {
        if viewModel.isValid {
            guard let customer = viewModel.customer else { return }
            coordinator?.configureBankingBillet(to: customer, with: viewModel.items)
        }
    }
}


// MARK: Delegates

extension AddItemsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        let minNumberOfCells = 2  //(empty cell or item detail cells) + item action cell
        return max(minNumberOfCells, viewModel.items.count + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if (viewModel.items.count == 0) && (indexPath.row == 0) {
            cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier) as! EmptyTableViewCell
        } else if indexPath.row < viewModel.items.count {
            cell = tableView.dequeueReusableCell(withIdentifier: ItemDetailsTableViewCell.identifier) as! ItemDetailsTableViewCell
            let item = viewModel.items[indexPath.section]
            (cell as! ItemDetailsTableViewCell).prepare(with: item)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: ButtonsTableViewCell.identifier) as! ButtonsTableViewCell
            (cell as! ButtonsTableViewCell).delegate = self
        }
        
        return cell
    }
    
    func reloadData() {
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: viewModel.items.count, section: 0), at: .bottom, animated: true)
    }
}

extension AddItemsViewController: ButtonsCellDelegate {
    
    func didTapAddItemButton() {
        coordinator?.addItemPopup(to: self)
    }
    
    func didTapSearchItemButton() {
        coordinator?.searchItem(to: self)
    }
    
    func addItem(_ item: ItemModel) {
        viewModel.items.append(item)
        reloadData()
        nextButton.setEnable(viewModel.isValid)
    }
}

extension AddItemsViewController: AddItemDelegate {
    
    func didAddItem(item: ItemModel) {
        addItem(item)
    }
}

extension AddItemsViewController: SearchItemDelegate {
    
    func didSelectItem(item: ItemModel) {
        addItem(item)
    }
}
