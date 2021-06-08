//
//  UpdateItemPopupViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 25/05/21.
//

import UIKit

protocol EditItemDelegate: AnyObject {
    
    func didEditItem(_ oldItem: ItemModel, _ newItem: ItemModel)
}

class EditItemPopupViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var validationViews: [UIView]!
    @IBOutlet var errorMessageLabels: [UILabel]!
 
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var cancelButton: BackButton!
    @IBOutlet weak var editButton: NextButton!
    
    @IBOutlet weak var popupView: UIView!
    

    // MARK: - Member types
    
    private enum FieldType: Int, CaseIterable {
        case name, value, amount
    }
    
    // MARK: - Member variables
    
    weak var coordinator: MainCoordinator?
    weak var delegate: EditItemDelegate?
    private var viewModel = EditItemPopupViewModel()
    
    
    // MARK: - Public methods
    
    func prepare(withItem item: ItemModel) {
        viewModel.oldItem = item
        textFields[FieldType.name.rawValue].insertText(item.name)
        textFields[FieldType.value.rawValue].insertText(item.value.description)
        textFields[FieldType.amount.rawValue].replace(withText: item.amount.description)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.decreaseButton.addTarget(self, action: #selector(self.handleDecreaseButton(sender:)), for: .touchUpInside)
        self.increaseButton.addTarget(self, action: #selector(self.handleIncreaseButton(sender:)), for: .touchUpInside)
        self.cancelButton.addTarget(self, action: #selector(self.handleTapCancelButton(sender:)), for: .touchUpInside)
        self.editButton.addTarget(self, action: #selector(self.handleTapEditItem), for: .touchUpInside)
        
        setup()
        bindTextFields()
        observeEvents()
    }
    
    
    // MARK: - Setups
    
    private func setup() {
        popupView.layer.cornerRadius = CGFloat(6)
        popupView.layer.masksToBounds = true
        
        (textFields[FieldType.value.rawValue] as! CurrencyTextField).currency = Currency(locale: Constants.LocaleIdentifier.ptBR, amount: 0.0)
    }
    
    
    // MARK: - Handlers
    
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
        
        (textFields[FieldType.value.rawValue] as! CurrencyTextField).passTextFieldText = { [weak self] cleanedText, _ in
            self?.viewModel.validadeField(FieldType.value.rawValue, value: cleanedText)
            self?.viewModel.value = cleanedText
            self?.editButton.setEnable(self?.viewModel.isValid ?? false)
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
        dismiss(animated: true)
    }
    
    @objc
    private func handleTapEditItem() {
        guard let oldItem = viewModel.oldItem else { return }
        let newItem = viewModel.getItem()
        delegate?.didEditItem(oldItem, newItem)
        dismiss(animated: true)
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
                        self?.editButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .amount:
                    (textField as! BindingTextField).bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.amount = $0
                        self?.editButton.setEnable(self?.viewModel.isValid ?? false)
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

extension EditItemPopupViewController: UITextFieldDelegate {
    
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
