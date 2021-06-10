//
//  AddItemPopupViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 25/05/21.
//

import UIKit

protocol AddItemDelegate: AnyObject {
    
    func didAddItem(_ item: ItemModel)
}

class AddItemPopupViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var validationViews: [UIView]!
    @IBOutlet var errorMessageLabels: [UILabel]!

    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var cancelButton: BackButton!
    @IBOutlet weak var addButton: NextButton!
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var bottonConstraint: NSLayoutConstraint!
    
    
    // MARK: - Member types
    
    private enum FieldType: Int, CaseIterable {
        case name, value, amount
    }
    
    // MARK: - Member variables
    
    weak var coordinator: MainCoordinator?
    weak var delegate: AddItemDelegate?
    private var viewModel = AddItemPopupViewModel()
    private var originalConstantBottonConstraint = CGFloat(0.0)
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.decreaseButton.addTarget(self, action: #selector(self.handleDecreaseButton(sender:)), for: .touchUpInside)
        self.increaseButton.addTarget(self, action: #selector(self.handleIncreaseButton(sender:)), for: .touchUpInside)
        self.cancelButton.addTarget(self, action: #selector(self.handleTapCancelButton(sender:)), for: .touchUpInside)
        self.addButton.addTarget(self, action: #selector(self.handleTapAddItem), for: .touchUpInside)
        
        setup()
        bindTextFields()
        observeEvents()
    }
    
    
    // MARK: - Setups
    
    private func setup() {
        setupCurrencyTextField()
        setupBottonContraint()
        popupView.layer.cornerRadius = CGFloat(6)
        popupView.layer.masksToBounds = true
    }
    
    private func setupCurrencyTextField() {
        (textFields[FieldType.value.rawValue] as! CurrencyTextField).currency = Currency(locale: Constants.LocaleIdentifier.ptBR, amount: 0.0)
    }
    
    private func setupBottonContraint() {
        originalConstantBottonConstraint = view.frame.height - (view.center.y + popupView.frame.height / CGFloat(2.0))
        self.bottonConstraint.constant = originalConstantBottonConstraint
    }
    
    
    // MARK: - Event handlers
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func observeEvents() {
        viewModel.validatedField = { [unowned self] result, indexField in
            guard let field = FieldType(rawValue: indexField) else { return }
            guard let value = textFields[field.rawValue].text else { return }
            
            // there is no validation view and error message for amount field
            let validationLine = field != .amount ? validationViews[field.rawValue] : nil
            let errorMessage = field != .amount ? errorMessageLabels[field.rawValue] : nil
               
            if value.isEmpty {
                validationLine?.backgroundColor = Constants.Color.gnLightGray
                errorMessage?.alpha = 0
            }
            else if result == true {
                validationLine?.backgroundColor = Constants.Color.gnGreen
                errorMessage?.alpha = 0
            } else {
                validationLine?.backgroundColor = Constants.Color.gnDarkRed
                errorMessage?.alpha = 1
            }
        }
        
        (textFields[FieldType.value.rawValue] as! CurrencyTextField).passTextFieldText = { [weak self] cleanedText, _ in
            self?.viewModel.validadeField(FieldType.value.rawValue, value: cleanedText)
            self?.viewModel.value = cleanedText
            self?.addButton.setEnable(self?.viewModel.isValid ?? false)
        }
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector (keyboardWillBeShown(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector (keyboardWillBeHidden(_ :)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc
    private func handleDecreaseButton(sender: UIButton) {
        guard let amount = (textFields[FieldType.amount.rawValue].text as NSString?)?.integerValue else { return }
        textFields[FieldType.amount.rawValue].replace(withText: max(1, amount - 1).description)
    }
    
    @objc
    private func handleIncreaseButton(sender: UIButton) {
        guard let amount = (textFields[FieldType.amount.rawValue].text as NSString?)?.integerValue else { return }
        textFields[FieldType.amount.rawValue].replace(withText: max(1, amount + 1).description)
    }
    
    @objc
    private func handleTapCancelButton(sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc
    private func handleTapAddItem() {
        let item = viewModel.getItem()
        delegate?.didAddItem(item)
        dismiss(animated: true)
    }
    
    @objc
    private func keyboardWillBeShown(_ notification: Notification) {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            bottonConstraint.constant = keyboardSize.cgRectValue.height + 23
            UIView.animate(withDuration: 1.0) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc
    private func keyboardWillBeHidden(_ notification: Notification) {
        bottonConstraint.constant = originalConstantBottonConstraint
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    // MARK: - Data binding
    
    private func bindTextFields() {
        
        for (index, textField) in textFields.enumerated() {
            if let field = FieldType(rawValue: index) {
                switch field {
                case .name:
                    (textField as! BindingTextField).bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.name = $0
                        self?.addButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case.amount:
                    (textField as! BindingTextField).bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.amount = $0
                        self?.addButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                default:
                    break
                }
                
                textField.delegate = self
            }
        }
    }
}


// MARK: - Delegates

extension AddItemPopupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var field: FieldType?
        for (index, _) in textFields.enumerated() {
            if textFields[index] == textField {
                field = FieldType(rawValue: index)
            }
        }
        
        guard var field = field else { return false }
        
        switch field {
        case .name:
            field.next()
            textFields[field.rawValue].becomeFirstResponder()
        case .value:
            textFields[field.rawValue].resignFirstResponder()
        default:
            break
        }
        
        return true
    }
}
