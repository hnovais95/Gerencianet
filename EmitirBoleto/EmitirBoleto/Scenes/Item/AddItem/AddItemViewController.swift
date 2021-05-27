//
//  AddItemsViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 24/05/21.
//

import UIKit

class AddItemViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    var customer: CustomerModel?
    var items: [ItemModel] = []
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(EmptyItemTableViewCell.nib(), forCellReuseIdentifier: EmptyItemTableViewCell.identifier)
            tableView.register(ItemDetailsTableViewCell.nib(), forCellReuseIdentifier: ItemDetailsTableViewCell.identifier)
            tableView.register(ItemActionsTableViewCell.nib(), forCellReuseIdentifier: ItemActionsTableViewCell.identifier)
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.addTarget(self, action: #selector(handleTapBackButton(_:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(handleTapNextButton(_:)), for: .touchUpInside)
        
        setupButtons()
    }
    
    @objc
    private func handleTapBackButton(_ sender: UIButton) {
        coordinator?.back()
    }
    
    @objc
    private func handleTapNextButton(_ sender: UIButton) {
       // implementação
    }
}

extension AddItemViewController {
    
    func setupButtons() {
        backButton.layer.borderWidth = 1.0
        backButton.layer.borderColor = Constants.Color.laranja.cgColor
        
        nextButton.layer.borderWidth = 1.0
        nextButton.layer.borderColor = Constants.Color.cinzaEscuro.cgColor
        nextButton.backgroundColor = Constants.Color.cinzaClaro
        nextButton.setTitleColor(UIColor.white, for: .normal)
    }
}

extension AddItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        let minNumberOfCells = 2  //(empty cell or item detail cells) + item action cell
        return max(minNumberOfCells, items.count + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if (items.count == 0) && (indexPath.row == 0) {
            cell = tableView.dequeueReusableCell(withIdentifier: EmptyItemTableViewCell.identifier) as! EmptyItemTableViewCell
        } else if indexPath.row < items.count {
            cell = tableView.dequeueReusableCell(withIdentifier: ItemDetailsTableViewCell.identifier) as! ItemDetailsTableViewCell
            let item = items[indexPath.section]
            (cell as! ItemDetailsTableViewCell).prepare(with: item)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: ItemActionsTableViewCell.identifier) as! ItemActionsTableViewCell
        }
        
        return cell
    }
}
