//
//  ItemDetailsTableViewCell.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 24/05/21.
//

import UIKit

class ItemDetailsTableViewCell: UITableViewCell {    
    
    // MARK: Initializer
    
    static let identifier = "ItemDetailsTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    // MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    
    // MARK: Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLayout()
    }
    
    
    // MARK: Layout
    
    func setupLayout() {
        view.layer.borderWidth = 1.0
        view.layer.borderColor = Constants.Color.cinzaClaro.cgColor
    }
    
    
    // MARK: Handlers
    
    func prepare(with item: ItemModel) {
        nameLabel.text = item.name
        valueLabel.text = Helper.getPrice(item.value)
        amountLabel.text = item.amount.description
        totalLabel.text = Helper.getPrice(item.total)
    }
}
