//
//  ItemTableViewCell.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 21/05/21.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    static let identifier = "ItemTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepare(with item: ItemModel) {
        nameLabel.text = item.name
        valueLabel.text = Helper.getPrice(item.value)
    }
}
