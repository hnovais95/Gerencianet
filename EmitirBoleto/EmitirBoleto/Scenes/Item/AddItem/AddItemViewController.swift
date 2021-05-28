//
//  AddItemsViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 24/05/21.
//

import UIKit

class AddItemViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(EmptyItemTableViewCell.nib(), forCellReuseIdentifier: EmptyItemTableViewCell.identifier)
            tableView.register(ItemDetailsTableViewCell.nib(), forCellReuseIdentifier: ItemDetailsTableViewCell.identifier)
            tableView.register(ItemActionsTableViewCell.nib(), forCellReuseIdentifier: ItemActionsTableViewCell.identifier)
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var backButton: BackButton!
    @IBOutlet weak var nextButton: NextButton!
    
    
    // MARK: Member variables
    
    weak var coordinator: MainCoordinator?
    var customer: CustomerModel?
    private var items: [ItemModel] = []
    
    
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
       // implementação
    }
}


// MARK: Delegates

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
