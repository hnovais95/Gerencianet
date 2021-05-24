//
//  AddItemsViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 24/05/21.
//

import UIKit

class AddItemsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(ItemDetailsTableViewCell.nib(), forCellReuseIdentifier: ItemDetailsTableViewCell.identifier)
            tableView.register(ItemActionsTableViewCell.nib(), forCellReuseIdentifier: ItemActionsTableViewCell.identifier)
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var items: [ItemModel] = [ItemModel("Playstation", 100, 3), ItemModel("Playstation", 100, 3), ItemModel("Playstation", 100, 3)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
    }
}

extension AddItemsViewController {
    
    func setupButtons() {
        backButton.layer.borderWidth = 1.0
        backButton.layer.borderColor = Constants.Color.laranja.cgColor
        
        nextButton.layer.borderWidth = 1.0
        nextButton.layer.borderColor = Constants.Color.cinzaEscuro.cgColor
        nextButton.backgroundColor = Constants.Color.cinzaClaro
        nextButton.setTitleColor(UIColor.white, for: .normal)
    }
}

extension AddItemsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if indexPath.row < items.count {
            cell = tableView.dequeueReusableCell(withIdentifier: ItemDetailsTableViewCell.identifier) as! ItemDetailsTableViewCell
            let item = items[indexPath.section]
            (cell as! ItemDetailsTableViewCell).prepare(with: item)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: ItemActionsTableViewCell.identifier) as! ItemActionsTableViewCell
        }
        
        return cell
    }
}
