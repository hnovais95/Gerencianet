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
    
    // MARK: Outlets
    
    @IBOutlet var textFields: [BindingTextField]!
    @IBOutlet var validationViews: [UIView]!
    @IBOutlet var errorMessageLabels: [UILabel]!

    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var cancelButton: BackButton!
    @IBOutlet weak var addButton: NextButton!
    
    @IBOutlet weak var popupView: UIView!
    
    
    // MARK: Member types
    
    private enum FieldType: Int, CaseIterable {
        case name, value, amount
    }
    
    // MARK: Member variables
    
    weak var coordinator: MainCoordinator?
    weak var delegate: AddItemDelegate?
    private var viewModel = AddItemPopupViewModel()
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.decreaseButton.addTarget(self, action: #selector(self.handleDecreaseButton(sender:)), for: .touchUpInside)
        self.increaseButton.addTarget(self, action: #selector(self.handleIncreaseButton(sender:)), for: .touchUpInside)
        self.cancelButton.addTarget(self, action: #selector(self.handleTapCancelButton(sender:)), for: .touchUpInside)
        self.addButton.addTarget(self, action: #selector(self.handleTapAddItem), for: .touchUpInside)
        
        setupLayout()
        bindTextFields()
        observeEvents()
    }
    
    
    // MARK: Layout
    
    private func setupLayout() {
        popupView.layer.cornerRadius = CGFloat(6)
        popupView.layer.masksToBounds = true
    }
    
    
    // MARK: Handlers
    
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
                validationLine?.backgroundColor = Constants.Color.cinzaClaro
                errorMessage?.alpha = 0
            }
            else if result == true {
                validationLine?.backgroundColor = Constants.Color.verde
                errorMessage?.alpha = 0
            } else {
                validationLine?.backgroundColor = Constants.Color.vermelhoEscuro
                errorMessage?.alpha = 1
            }
        }
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
        coordinator?.dismiss()
    }
    
    @objc
    private func handleTapAddItem() {
        let item = viewModel.getItem()
        delegate?.didAddItem(item)
        coordinator?.dismiss()
    }
    
    
    // MARK: Data binding
    
    private func bindTextFields() {
        for (index, textField) in textFields.enumerated() {
            if let field = FieldType(rawValue: index) {
                switch field {
                case .name:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.name = $0
                        self?.addButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .value:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.value = $0
                        self?.addButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .amount:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.amount = $0
                        self?.addButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                }                
                
                textField.delegate = self
            }
        }
    }
}

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
