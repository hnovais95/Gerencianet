//
//  CustomerTableViewCell.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 21/05/21.
//

import UIKit

class CustomersTableViewCell: UITableViewCell {
    
    // MARK: Initializer
    
    static let identifier = "CustomersTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    // MARK: Outlets

    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var iconTitleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var identifierLabel: UILabel!
    
    
    // MARK: Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLayout()
    }
    
    
    // MARK: Layout
    
    private func setupLayout() {
        iconView.layer.borderWidth = 1.0
        iconView.layer.borderColor = Constants.Color.azul.cgColor
        iconView.layer.masksToBounds = true
        iconView.layer.cornerRadius = iconView.frame.width / 2
    }
    
    
    // MARK: Handlers
    
    func prepare(with customer: CustomerModel) {
        nameLabel.text = customer.name
        identifierLabel.text = customer.isJuridicalPerson() ? customer.juridicalPerson?.cnpj : customer.cpf
        iconTitleLabel.text = Helper.getInitialsName(customer.name)
    }
}



