//
//  SuccessViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 25/05/21.
//

import UIKit

class SuccessViewController: UIViewController {
    
    // MARK: Outlets

    @IBOutlet weak var copyBarcodeButton: UIButton!
    @IBOutlet weak var shareLinkButton: UIButton!
    @IBOutlet weak var showBankingBilletButton: UIButton!
    @IBOutlet weak var doneButton: NextButton!
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtons()
    }
    
    
    // MARK: Layout
    
    func setupButtons() {
        copyBarcodeButton.layer.borderWidth = 1.0
        copyBarcodeButton.layer.borderColor = Constants.Color.azul.cgColor
        
        shareLinkButton.layer.borderWidth = 1.0
        shareLinkButton.layer.borderColor = Constants.Color.azul.cgColor
        
        showBankingBilletButton.layer.borderWidth = 1.0
        showBankingBilletButton.layer.borderColor = Constants.Color.azul.cgColor
        
        doneButton.setEnable(true)
    }
}
