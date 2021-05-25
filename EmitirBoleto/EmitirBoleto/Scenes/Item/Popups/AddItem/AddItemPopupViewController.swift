//
//  AddItemPopupViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 25/05/21.
//

import UIKit

class AddItemPopupViewController: UIViewController {
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.decreaseButton.addTarget(self, action: #selector(self.handleDecreaseButton(sender:)), for: .touchUpInside)
        self.increaseButton.addTarget(self, action: #selector(self.handleIncreaseButton(sender:)), for: .touchUpInside)
        self.cancelButton.addTarget(self, action: #selector(self.handleCancelButton(sender:)), for: .touchUpInside)
        self.addButton.addTarget(self, action: #selector(self.handlePerformActionButton(sender:)), for: .touchUpInside)
        
        setupLayout()
        setupButtons()
    }
    
    @objc
    func handleDecreaseButton(sender: UIButton) {
        guard let amount = (amountTextField.text as NSString?)?.integerValue else { return }
        amountTextField.text = max(0, amount - 1).description
    }
    
    @objc
    func handleIncreaseButton(sender: UIButton) {
        guard let amount = (amountTextField.text as NSString?)?.integerValue else { return }
        amountTextField.text = max(0, amount + 1).description
    }
    
    @objc
    func handleCancelButton(sender: UIButton) {
        
    }
    
    @objc
    func handlePerformActionButton(sender: UIButton) {
        
    }
}

extension AddItemPopupViewController {
    
    func setupLayout() {
        popupView.layer.cornerRadius = CGFloat(6)
        popupView.layer.masksToBounds = true
    }
    
    func setupButtons() {
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.borderColor = Constants.Color.laranja.cgColor
        
        addButton.layer.borderWidth = 1.0
        addButton.layer.borderColor = Constants.Color.laranja.cgColor
        addButton.backgroundColor = Constants.Color.laranja
        addButton.setTitleColor(UIColor.white, for: .normal)
    }
}

