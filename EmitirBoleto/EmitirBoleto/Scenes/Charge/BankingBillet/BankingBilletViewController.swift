//
//  ChargeViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 25/05/21.
//

import UIKit

class BankingBilletViewController: UIViewController {

    @IBOutlet weak var expireAtTextField: UITextField!
    @IBOutlet weak var shippingTextField: UITextField!
    @IBOutlet weak var additionalFieldsSwitch: UISwitch!
    @IBOutlet weak var additionalFieldsStackView: UIStackView!
    @IBOutlet weak var discountUnitTextField: UITextField!
    @IBOutlet weak var discountUnitSelectorButton: UIButton!
    @IBOutlet weak var discountAmountTextField: UITextField!
    @IBOutlet weak var conditionalDiscountUnitTextField: UITextField!
    @IBOutlet weak var conditionalDiscountUnitSelectorButton: UIButton!
    @IBOutlet weak var conditionalDiscountAmountTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var chargeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtons()
    }

}

extension BankingBilletViewController {
    
    func setupButtons() {
        backButton.layer.borderWidth = 1.0
        backButton.layer.borderColor = Constants.Color.laranja.cgColor
        
        chargeButton.layer.borderWidth = 1.0
        chargeButton.layer.borderColor = Constants.Color.cinzaEscuro.cgColor
        chargeButton.backgroundColor = Constants.Color.cinzaClaro
        chargeButton.setTitleColor(UIColor.white, for: .normal)
    }
}
