//
//  PopupAddItemViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 24/05/21.
//

import UIKit

class BasePopupItemViewController: UIViewController {
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var performActionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.decreaseButton.addTarget(self, action: #selector(handleDecreaseButton(sender:)), for: .touchUpInside)
        self.increaseButton.addTarget(self, action: #selector(handleIncreaseButton(sender:)), for: .touchUpInside)
        self.cancelButton.addTarget(self, action: #selector(handleCancelButton(sender:)), for: .touchUpInside)
        self.performActionButton.addTarget(self, action: #selector(handlePerformActionButton(sender:)), for: .touchUpInside)
        
        setupLayout()
        setupButtons()
    }
    
    @objc
    func handleDecreaseButton(sender: UIButton) {
        
    }
    
    @objc
    func handleIncreaseButton(sender: UIButton) {
        
    }
    
    @objc
    func handleCancelButton(sender: UIButton) {
        
    }
    
    @objc
    func handlePerformActionButton(sender: UIButton) {
        
    }
}

extension BasePopupItemViewController {
    
    func setupLayout() {
        popupView.layer.cornerRadius = CGFloat(6)
        popupView.layer.masksToBounds = true
    }
    
    func setupButtons() {
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.borderColor = Constants.Color.laranja.cgColor
        
        performActionButton.layer.borderWidth = 1.0
        performActionButton.layer.borderColor = Constants.Color.laranja.cgColor
        performActionButton.backgroundColor = Constants.Color.laranja
        performActionButton.setTitleColor(UIColor.white, for: .normal)
    }
}
