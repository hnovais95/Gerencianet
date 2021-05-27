//
//  ItemDetailsTableViewCell.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 24/05/21.
//

import UIKit

class ItemActionsTableViewCell: UITableViewCell {
    
    // MARK: Initializer
    
    static let identifier = "ItemActionsTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    // MARK: Outlets

    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var consultItemButton: UIButton!
    
    
    // MARK: Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addItemButton.addTarget(self, action: #selector(handleAddItemButton(sender:)), for: .touchUpInside)
        self.consultItemButton.addTarget(self, action: #selector(handleConsultItemButton(sender:)), for: .touchUpInside)
    }
    
    
    // MARK: Handlers
    
    @objc
    func handleAddItemButton(sender: UIButton) {
        
    }
    
    @objc
    func handleConsultItemButton(sender: UIButton) {
        
    }
}
