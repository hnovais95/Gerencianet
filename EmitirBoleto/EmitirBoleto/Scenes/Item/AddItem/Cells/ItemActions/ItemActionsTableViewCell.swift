//
//  ItemDetailsTableViewCell.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 24/05/21.
//

import UIKit

class ItemActionsTableViewCell: UITableViewCell {
    
    static let identifier = "ItemActionsTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var consultItemButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addItemButton.addTarget(self, action: #selector(handleAddItemButton(sender:)), for: .touchUpInside)
        self.consultItemButton.addTarget(self, action: #selector(handleConsultItemButton(sender:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc
    func handleAddItemButton(sender: UIButton) {
        
    }
    
    @objc
    func handleConsultItemButton(sender: UIButton) {
        
    }
}
