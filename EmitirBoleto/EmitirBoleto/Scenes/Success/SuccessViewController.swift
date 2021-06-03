//
//  SuccessViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 25/05/21.
//

import UIKit

class SuccessViewController: UIViewController {
    
    // MARK: Outlets

    @IBOutlet var labels: [UILabel]!
    @IBOutlet weak var barcodeTextView: UITextView!
    @IBOutlet weak var copyBarcodeButton: UIButton!
    @IBOutlet weak var shareLinkButton: UIButton!
    @IBOutlet weak var showBankingBilletButton: UIButton!
    @IBOutlet weak var doneButton: NextButton!
    
    
    // MARK: Member types
    
    enum FieldType: Int, CaseIterable {
        case expireAt, value, customer
    }
    
    
    // MARK: Member variables
    
    weak var coordinator: MainCoordinator?
    var response: ChargeOneStepResponse?
    var customer: String?
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.doneButton.addTarget(self, action: #selector(self.handleTapDoneButton(_:)), for: .touchUpInside)

        setupButtons()
        prepare()
    }
    
    
    // MARK: Layout
    
    private func setupButtons() {
        copyBarcodeButton.layer.borderWidth = 1.0
        copyBarcodeButton.layer.borderColor = Constants.Color.azulEscuro.cgColor
        
        shareLinkButton.layer.borderWidth = 1.0
        shareLinkButton.layer.borderColor = Constants.Color.azulEscuro.cgColor
        
        showBankingBilletButton.layer.borderWidth = 1.0
        showBankingBilletButton.layer.borderColor = Constants.Color.azulEscuro.cgColor
        
        doneButton.setEnable(true)
    }
    
    private func prepare() {
        guard let response = self.response, let customer = self.customer else { return }
        labels[FieldType.expireAt.rawValue].text = Helper.convertDateToNormalFormat(response.data.expireAt)
        labels[FieldType.value.rawValue].text = Helper.getPrice(response.data.total)
        labels[FieldType.customer.rawValue].text = customer
        barcodeTextView.text = response.data.barcode
    }
    
    
    // MARK: Handles
    
    @objc
    private func handleTapDoneButton(_ sender: UIButton) {
        coordinator?.back()
    }
}
