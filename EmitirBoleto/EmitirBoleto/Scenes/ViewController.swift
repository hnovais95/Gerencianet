//
//  ViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 11/05/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
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
        
        user = UserModel(clientID: "client_id", clientSecret: "client_secrete")
        user.setToken("s5df4tg4")
        address = Address("Rua JK", 1, "Bauxita", "3540000", "Ouro Preto", "A", "MG")
        customer = CustomerModel("Heitor", "12226629492", "31985624589", "1995-12-01", "email@dominio.com", address)
        item = ItemModel("Produto 1", 10000, 2)
        shipping = ShippingModel("Correios", 2000, 1)
        bankingBillet = BankingBilletModel(customer: customer, expireAt: "2021-05-15")
        charge = ChargeOneStepModel(bankingBillet: bankingBillet)
        charge.add(item: item)
        charge.add(shipping: shipping)
        //gerencianetGateway = GerencianetGateway()
        
        //ChargeOneStepResponse("Heitor", "2021-05-15", 100000, "0000.0000", "www.sharedlink.com", "www.pdflink.com")
    }

    @IBAction func buttonAction(_ sender: Any) {
        let useCase = Charge(paymentGateway: gerencianetGateway)
        let response = useCase.createChargeOneStep(user: user, charge: charge)
        
        if let response = response {
            label.text = response.customer
        }
    }
    
}

