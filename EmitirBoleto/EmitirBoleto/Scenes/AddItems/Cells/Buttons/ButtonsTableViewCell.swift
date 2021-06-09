//
//  ItemDetailsTableViewCell.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 24/05/21.
//

import UIKit

protocol ButtonsCellDelegate: AnyObject {
    
    func didTapAddItemButton()
    func didTapSearchItemButton()
}


class ButtonsTableViewCell: UITableViewCell {
    
    // MARK: Initializer
    
    static let identifier = "ButtonsTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    // MARK: Outlets

    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var searchItemButton: UIButton!
    
    
    // MARK: Member variables
    
    weak var delegate: ButtonsCellDelegate?
    
    
    // MARK: Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addItemButton.addTarget(self, action: #selector(handleAddItemButton(sender:)), for: .touchUpInside)
        self.searchItemButton.addTarget(self, action: #selector(handleSearchItemButton(sender:)), for: .touchUpInside)
    }
    
    
    // MARK: Handlers
    
    @objc
    func handleAddItemButton(sender: UIButton) {
        delegate?.didTapAddItemButton()
    }
    
    @objc
    func handleSearchItemButton(sender: UIButton) {
        delegate?.didTapSearchItemButton()
    }
}
