//
//  SuccessViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 25/05/21.
//

import UIKit

class SuccessViewController: UIViewController {

    @IBOutlet weak var copyBarcodeButton: UIButton!
    @IBOutlet weak var shareLinkButton: UIButton!
    @IBOutlet weak var showBankingBilletButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtons()
    }
}

extension SuccessViewController {
    
    func setupButtons() {
        copyBarcodeButton.layer.borderWidth = 1.0
        copyBarcodeButton.layer.borderColor = Constants.Color.azul.cgColor
        
        shareLinkButton.layer.borderWidth = 1.0
        shareLinkButton.layer.borderColor = Constants.Color.azul.cgColor
        
        showBankingBilletButton.layer.borderWidth = 1.0
        showBankingBilletButton.layer.borderColor = Constants.Color.azul.cgColor
        
        doneButton.layer.borderWidth = 1.0
        doneButton.layer.borderColor = Constants.Color.laranja.cgColor
    }
}
