//
//  CustomerTableViewCell.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 21/05/21.
//

import UIKit

class CustomersTableViewCell: UITableViewCell {
    
    static let identifier = "CustomerTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var iconTitleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var identifierLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconView.layer.borderWidth = 1.0
        iconView.layer.borderColor = Constants.Color.azul.cgColor
        iconView.layer.masksToBounds = true
        iconView.layer.cornerRadius = iconView.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with customer: CustomerModel) {
        nameLabel.text = customer.name
        identifierLabel.text = customer.isJuridicalPerson() ? customer.juridicalPerson?.cnpj : customer.cpf
        iconTitleLabel.text = Helper.getInitialsName(customer.name)
    }
}



