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
        
        setup()
    }
    
    
    // MARK: Setups
    
    private func setup() {
        iconView.layer.borderWidth = 1.0
        iconView.layer.masksToBounds = true
        iconView.layer.cornerRadius = iconView.frame.width / 2
        iconView.layer.borderColor = Constants.Color.azulEscuro.cgColor
    }
    
    private func setIconBackgroundColorToNaturalPerson() {
        iconView.layer.backgroundColor = UIColor.white.cgColor
        iconTitleLabel.textColor = Constants.Color.azulEscuro
    }
    
    private func setIconBackgroundColorToJuridicalPerson() {
        iconView.layer.backgroundColor = Constants.Color.azulClaro.cgColor
        iconTitleLabel.textColor = UIColor.white
    }
    
    
    // MARK: Handlers
    
    func prepare(with customer: CustomerModel) {
        nameLabel.text = customer.name
        
        var identifier: String
        if customer.isJuridicalPerson {
            identifier = Helper.applyMask(text: customer.juridicalPerson!.cnpj, maskString: Constants.Mask.cnpj)
        } else {
            identifier = Helper.applyMask(text: customer.cpf, maskString: Constants.Mask.cpf)
        }
        
        identifierLabel.text = identifier
        iconTitleLabel.text = Helper.getInitialsName(customer.name)
        
        if customer.isJuridicalPerson {
            setIconBackgroundColorToJuridicalPerson()
        } else {
            setIconBackgroundColorToNaturalPerson()
        }
    }
}



