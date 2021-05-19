//
//  ViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

import UIKit

class ChargeViewController: UIViewController {
    @IBOutlet weak var authenticateButton: UIButton!
    @IBOutlet weak var authenticateLabel: UILabel!
    @IBOutlet weak var chargeButton: UIButton!
    @IBOutlet weak var chargeLabel: UILabel!
    
    let viewModel = ChargeViewModel()
    
    // MARK: Fields
    var address: AddressModel!
    var customer: CustomerModel!
    var item: ItemModel!
    var shipping: ShippingModel!
    var charge: ChargeOneStepModel!
    var bankingBillet: BankingBilletModel!
    var juridicalPerson: JuridicalPersonModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateButton.addTarget(self, action: #selector(authenticateButtonHandle), for: .touchUpInside)
        chargeButton.addTarget(self, action: #selector(chargeButtonHandle), for: .touchUpInside)
        
        // MARK: Init customer
        address = AddressModel("Rua da Sorte", 1, "Jardim Alvorada", "35400000", "Ouro Preto", "A", "MG")
        //juridicalPerson = JuridicalPersonModel("Novais Automação", "74926158000123")
        customer = CustomerModel("Marlon Rafael", "46282921678", "31985624589", "1995-12-01", "email@dominio.com"/*, juridicalPerson*/)
        // MARK: Init charge data
        item = ItemModel("Produto 2", 10000, 2)
        shipping = ShippingModel("Correios", 2000)
        bankingBillet = BankingBilletModel(customer: customer, expireAt: "2021-10-30")
        charge = ChargeOneStepModel(bankingBillet: bankingBillet)
        charge.add(item: item)
        charge.add(shipping: shipping)
    }
    
    @objc
    func authenticateButtonHandle() {
        let authenticate = Authenticate(paymentGateway: Gerencianet(httpClient: AlamofireClient()))
        
        authenticate.execute(user: UserModel.shared) { [weak self] result in
            switch result {
            case .success(let response):
                self?.authenticateLabel.text = response.accessToken
            default:
                break
            }
        }
    }
    
    @objc
    func chargeButtonHandle() {
        viewModel.chargeOneStep(data: charge)
    }
    
}
