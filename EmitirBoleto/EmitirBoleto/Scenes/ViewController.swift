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
    var gerencianetGateway: GerencianetClient!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = UserModel(clientID: "Client_Id_30ef246ffe7a828c813ee20b717702c85fe12407", clientSecret: "Client_Secret_43b9bb35170c383c53fa27d13253f3a2e0f045ea")
        user.updateToken("Bearer d1d310a6cfda775aaf9d4ca55ff6717a776934fd765df7ddcbf7b1c4f9f762fa")
        address = Address("Rua JK", 1, "Bauxita", "35400000", "Ouro Preto", "A", "MG")
        customer = CustomerModel("Heitor Novais", "46282921678", "31985624589", "1995-12-01", "email@dominio.com", address)
        item = ItemModel("Produto 1", 10000, 2)
        shipping = ShippingModel("Correios", 2000)
        bankingBillet = BankingBilletModel(customer: customer, expireAt: "2021-05-15")
        charge = ChargeOneStepModel(bankingBillet: bankingBillet)
        charge.add(item: item)
        charge.add(shipping: shipping)
        gerencianetGateway = GerencianetClient()
    }
}
