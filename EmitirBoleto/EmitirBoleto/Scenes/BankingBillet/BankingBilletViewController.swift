//
//  NewBankingBilletViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 01/06/21.
//

import UIKit

class BankingBilletViewController: UIViewController {
    
    // MARK: - Outlets    
    
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var validationViews: [UIView]!
    @IBOutlet weak var messageTextView: BindingTextView!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var additionalFieldsSwitch: UISwitch!
    @IBOutlet weak var backButton: BackButton!
    @IBOutlet weak var chargeButton: NextButton!
    @IBOutlet weak var expireAtPickerButton: UIButton!
    @IBOutlet weak var deadlinePickerButton: UIButton!
    @IBOutlet weak var discountTypeButton: UIButton!
    @IBOutlet weak var conditionalDiscountTypeButton: UIButton!
    
    @IBOutlet weak var additionalFieldsStackView: UIStackView!
    
    
    // MARK: - Member types
    
    enum FieldType: Int, CaseIterable {
        case expireAt, shippingValue, discountType, discountValue, conditionalDiscountType,
             conditionalDiscountValue, contitionalDiscountDeadline, message
    }
    
    
    // MARK: - Member variables
    
    weak var coordinator: MainCoordinator?
    private var viewModel = BankingBilletViewModel()
    private var discountTypePicker = DiscountTypePicker()
    private var conditionalDiscountTypePicker = DiscountTypePicker()
    
    
    // MARK: - Public methods
    
    func setRequiredData(_ customer: CustomerModel, _ items: [ItemModel]) {
        viewModel.customer = customer
        viewModel.items = items
    }
    
        
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.additionalFieldsSwitch.addTarget(self, action: #selector(handleSwitchChange(_:)), for: .valueChanged)
        self.backButton.addTarget(self, action: #selector(self.handleTapBackButton(_:)), for: .touchUpInside)
        self.chargeButton.addTarget(self, action: #selector(self.handleTapChargeButton), for: .touchUpInside)
        self.expireAtPickerButton.addTarget(self, action: #selector(handleBeginExpireAtPicker), for: .touchUpInside)
        self.deadlinePickerButton.addTarget(self, action: #selector(handleBeginDeadlinePicker), for: .touchUpInside)
        self.textFields[FieldType.discountType.rawValue].addTarget(self, action: #selector(handleBeginEditingPicker(_:)), for: .editingDidBegin)
        self.textFields[FieldType.conditionalDiscountType.rawValue].addTarget(self, action: #selector(handleBeginEditingPicker(_:)), for: .editingDidBegin)
        self.discountTypeButton.addTarget(self, action: #selector(handleTapDiscountTypePickerButton), for: .touchUpInside)
        self.conditionalDiscountTypeButton.addTarget(self, action: #selector(handleTapConditionalDiscountTypePickerButton), for: .touchUpInside)
        
        discountTypePicker.delegate = self
        conditionalDiscountTypePicker.delegate = self
        messageTextView.delegate = self
        
        setup()
        bindTextFields()
        observeEvents()
    }

    
    // MARK: - Setups
    
    private func setup() {
        messageTextView.layer.borderWidth = 1.0
        messageTextView.layer.borderColor = Constants.Color.cinzaClaro.cgColor
        
        additionalFieldsSwitch.isOn = false
        additionalFieldsStackView.isHidden = true
        
        messageTextView.textContainer.maximumNumberOfLines = 4
        messageTextView.textContainer.lineBreakMode = .byTruncatingTail
        
        setupPickerTextFields()
        
        totalLabel.text = viewModel.total
    }
    
    private func setupPickerTextFields() {
        textFields[FieldType.discountType.rawValue].tintColor = .clear
        textFields[FieldType.conditionalDiscountType.rawValue].tintColor = .clear
        textFields[FieldType.expireAt.rawValue].tintColor = .clear
        textFields[FieldType.contitionalDiscountDeadline.rawValue].tintColor = .clear
        
        // Setup pickers
        textFields[FieldType.discountType.rawValue].inputView = createDiscountTypePicker(with: discountTypePicker)
        textFields[FieldType.conditionalDiscountType.rawValue].inputView = createDiscountTypePicker(with: conditionalDiscountTypePicker)
        textFields[FieldType.expireAt.rawValue].inputView = createDatePicker(action: #selector(handleExpireAtDatePickerChange(_:)))
        textFields[FieldType.contitionalDiscountDeadline.rawValue].inputView = createDatePicker(action: #selector(handleDeadlineDatePickerChange(_:)))
        setupCurrencyTextField()
    }
    
    private func setupCurrencyTextField() {
        (textFields[FieldType.shippingValue.rawValue] as! CurrencyTextField).currency = Currency(locale: Constants.LocaleIdentifier.ptBR, amount: 0.0)
    }
    
    private func setupFractionalNumberTextFields() {
        (textFields[FieldType.discountValue.rawValue] as! FractionalNumberTextField).regionCode = Constants.LocaleIdentifier.ptBR
        (textFields[FieldType.conditionalDiscountValue.rawValue] as! FractionalNumberTextField).regionCode = Constants.LocaleIdentifier.ptBR
    }
    
    private func createDatePicker(action: Selector) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: action, for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 150)
        datePicker.backgroundColor = Constants.Color.laranja
        datePicker.tintColor = .white
        return datePicker
    }
    
    private func createDiscountTypePicker(with picker: DiscountTypePicker) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = picker
        pickerView.dataSource = picker
        return pickerView
    }
    
    
    // MARK: - Handlers
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func observeEvents() {
        viewModel.validatedField = { [unowned self] result, rawValue in
            guard let field = FieldType(rawValue: rawValue), field != .message else { return }
            guard let value = textFields[field.rawValue].text else { return }
            
            let validationLine = validationViews[field.rawValue]
            
            if ((field == .discountType) || (field == .conditionalDiscountType)) { return }
            
            let priceZero = Helper.getPrice(0)
            let zero = "0,00"
            
            if (value.isEmpty || value == priceZero || value == zero) {
                validationLine.backgroundColor = Constants.Color.cinzaClaro
            }
            else if result == true {
                validationLine.backgroundColor = Constants.Color.verde
            } else {
                validationLine.backgroundColor = Constants.Color.vermelhoEscuro
            }
        }        
        
        (textFields[FieldType.shippingValue.rawValue] as! CurrencyTextField).passTextFieldText = { [weak self] cleanedText, value in
            let shippingValue = value != 0 ? cleanedText : ""
            self?.viewModel.validadeField(FieldType.shippingValue.rawValue, value: shippingValue)
            self?.viewModel.shippingValue = shippingValue
            self?.totalLabel.text = self?.viewModel.total
            self?.chargeButton.setEnable(self?.viewModel.isValid ?? false)
        }
        
        (textFields[FieldType.discountValue.rawValue] as! FractionalNumberTextField).passTextFieldText = { [weak self] cleanedText, value in
            let discountValue = value != 0 ? cleanedText : ""
            self?.viewModel.validadeField(FieldType.discountValue.rawValue, value: discountValue)
            self?.viewModel.discountValue = discountValue
            self?.totalLabel.text = self?.viewModel.total
            self?.chargeButton.setEnable(self?.viewModel.isValid ?? false)
        }
        
        (textFields[FieldType.conditionalDiscountValue.rawValue] as! FractionalNumberTextField).passTextFieldText = { [weak self] cleanedText, value in
            let conditionalDiscountValue = value != 0 ? cleanedText : ""
            self?.viewModel.validadeField(FieldType.conditionalDiscountValue.rawValue, value: conditionalDiscountValue)
            self?.viewModel.conditionalDiscountValue = conditionalDiscountValue
            self?.totalLabel.text = self?.viewModel.total
            self?.chargeButton.setEnable(self?.viewModel.isValid ?? false)
        }
    }
    
    @objc
    private func handleSwitchChange(_ sender: UISwitch) {
        additionalFieldsStackView.isHidden = !sender.isOn
    }
    
    @objc
    private func handleTapBackButton(_ sender: UIButton) {
        coordinator?.back()
    }
    
    @objc
    private func handleTapChargeButton() {
        if viewModel.isValid {
            let data = viewModel.getChargeData()
            coordinator?.createCharge(with: data)
        }
    }
    
    @objc
    private func handleExpireAtDatePickerChange(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        textFields[FieldType.expireAt.rawValue].replace(withText: formatter.string(from: sender.date))
        textFields[FieldType.expireAt.rawValue].resignFirstResponder()
    }
    
    @objc
    private func handleDeadlineDatePickerChange(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        textFields[FieldType.contitionalDiscountDeadline.rawValue].replace(withText: formatter.string(from: sender.date))
        textFields[FieldType.contitionalDiscountDeadline.rawValue].resignFirstResponder()
    }
    
    @objc
    private func handleBeginEditingPicker(_ sender: BindingTextField) {
        sender.becomeFirstResponder()
    }
    
    @objc
    private func handleBeginExpireAtPicker() {
        textFields[FieldType.expireAt.rawValue].becomeFirstResponder()
    }
    
    @objc
    private func handleBeginDeadlinePicker() {
        textFields[FieldType.contitionalDiscountDeadline.rawValue].becomeFirstResponder()
    }
    
    @objc
    private func handleTapDiscountTypePickerButton() {
        textFields[FieldType.discountType.rawValue].becomeFirstResponder()
    }
    
    @objc
    private func handleTapConditionalDiscountTypePickerButton() {
        textFields[FieldType.conditionalDiscountType.rawValue].becomeFirstResponder()
    }
    
    
    // MARK: - Data binding
    
    private func bindTextFields() {
        for (index, textField) in textFields.enumerated() {
            if let field = FieldType(rawValue: index) {
                switch field {
                case .expireAt:
                    (textField as! BindingTextField).bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: Helper.convertDateToReverseFormat($0) ?? $0)
                        self?.viewModel.expireAt = Helper.convertDateToReverseFormat($0) ?? $0
                        self?.chargeButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .discountType:
                    (textField as! BindingTextField).bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0.description)
                        self?.viewModel.discountType = DiscountType(rawValue: $0)!
                        self?.totalLabel.text = self?.viewModel.total
                        self?.chargeButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .conditionalDiscountType:
                    (textField as! BindingTextField).bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0.description)
                        self?.viewModel.conditionalDiscountType = DiscountType(rawValue: $0)!
                        self?.totalLabel.text = self?.viewModel.total
                        self?.chargeButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .contitionalDiscountDeadline:
                    (textField as! BindingTextField).bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: Helper.convertDateToReverseFormat($0) ?? $0)
                        self?.viewModel.conditionalDiscountDeadline = Helper.convertDateToReverseFormat($0) ?? $0
                        self?.chargeButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                default:
                    break
                }
                
                textField.delegate = self
            }
        }
        
        messageTextView.bind { [weak self] in
            self?.viewModel.validadeField(FieldType.message.rawValue, value: $0)
            self?.viewModel.message = $0
            self?.chargeButton.setEnable(self?.viewModel.isValid ?? false)
        }
    }
}


// MARK: - Delegates

extension BankingBilletViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.message = textView.text
    }
}

extension BankingBilletViewController: DiscountTypePickerDelegate {
    
    func didSelectType(type: DiscountType) {
        guard let textField = textFields.first(where: { $0.isFirstResponder }) else {
            return
        }
        
        if (textField == textFields[FieldType.discountType.rawValue])
        || (textField == textFields[FieldType.conditionalDiscountType.rawValue]) {
            textField.replace(withText: type.rawValue)
            textField.resignFirstResponder()
        }
    }
}

extension BankingBilletViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
