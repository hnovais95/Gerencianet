//
//  ViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var authenticateButton: UIButton!
    @IBOutlet weak var authenticateLabel: UILabel!
    @IBOutlet weak var chargeButton: UIButton!
    @IBOutlet weak var chargeLabel: UILabel!
    
    var user: UserModel!
    var address: Address!
    var customer: CustomerModel!
    var item: ItemModel!
    var shipping: ShippingModel!
    var charge: ChargeOneStepModel!
    var bankingBillet: BankingBilletModel!
    var gerencianetGateway: Gerencianet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateButton.addTarget(self, action: #selector(authenticateButtonHandle), for: .touchUpInside)
        chargeButton.addTarget(self, action: #selector(chargeButtonHandle), for: .touchUpInside)
        
        user = UserModel(clientID: "Client_Id_e89b59870bcfc8285adc603662fafb60e403ccb1", clientSecret: "Client_Secret_35f3fbcd52bfb705701e5cf769501d8b8c32f0a8")
        address = Address("Rua JK", 1, "Bauxita", "35400000", "Ouro Preto", "A", "MG")
        customer = CustomerModel("Heitor Novais", "46282921678", "31985624589", "1995-12-01", "email@dominio.com", address)
        item = ItemModel("Produto 1", 10000, 2)
        shipping = ShippingModel("Correios", 2000)
        bankingBillet = BankingBilletModel(customer: customer, expireAt: "2021-05-30")
        charge = ChargeOneStepModel(bankingBillet: bankingBillet)
        charge.add(item: item)
        charge.add(shipping: shipping)
        gerencianetGateway = Gerencianet(httpClient: AlamofireClient())
    }
    
    @objc
    func authenticateButtonHandle() {
        Authenticate(authenticator: gerencianetGateway).authorize(user: user) { [unowned self] result in
            switch result {
            case .success:
                authenticateLabel.text = user.token
                break
            default:
                break
            }
        }
    }
    
    @objc
    func chargeButtonHandle() {
        Charge(paymentGateway: gerencianetGateway).createChargeOneStep(user: user, charge: charge) { [unowned self] result in
            switch result {
            case .success(let response):
                chargeLabel.text = response.data.chargeId.description
                break
            default:
                //authenticateButtonHandle()
                //chargeButtonHandle()
                break
            }
        }
    }
    
}
