//
//  ChargeViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 25/05/21.
//

import UIKit

class BankingBilletViewController: UIViewController {
    
    // MARK: Outlets

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
    @IBOutlet weak var backButton: BackButton!
    @IBOutlet weak var chargeButton: NextButton!
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: Layout
    
    
}
