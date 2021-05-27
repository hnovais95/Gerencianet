//
//  EmptyItemTableViewCell.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 24/05/21.
//

import UIKit

class EmptyItemTableViewCell: UITableViewCell {
    
    // MARK: Initializer

    static let identifier = "EmptyItemTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    // MARK: Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
