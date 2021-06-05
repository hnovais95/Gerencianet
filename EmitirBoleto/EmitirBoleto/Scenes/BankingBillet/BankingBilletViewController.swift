//
//  NewBankingBilletViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 01/06/21.
//

import UIKit

class BankingBilletViewController: UIViewController {
    
    // MARK: - Outlets    
    
    @IBOutlet var textFields: [BindingTextField]!
    @IBOutlet var validationViews: [UIView]!
    @IBOutlet weak var messageTextView: UITextView!
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
             contitionalDiscountValue, contitionalDiscountDeadline
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
        
        setupLayout()
        bindTextFields()
        observeEvents()
    }

    
    // MARK: - Layout
    
    private func setupLayout() {
        messageTextView.layer.borderWidth = 1.0
        messageTextView.layer.borderColor = Constants.Color.cinzaClaro.cgColor
        
        setupComponents()
    }

    private func setupComponents() {
        // Initial states
        additionalFieldsSwitch.setOn(false, animated: false)
        additionalFieldsStackView.isHidden = true
        textFields[FieldType.discountType.rawValue].tintColor = .clear
        textFields[FieldType.conditionalDiscountType.rawValue].tintColor = .clear
        textFields[FieldType.expireAt.rawValue].tintColor = .clear
        textFields[FieldType.contitionalDiscountDeadline.rawValue].tintColor = .clear
        totalLabel.text = viewModel.total
        
        // Setup pickers
        textFields[FieldType.discountType.rawValue].inputView = createDiscountTypePicker(with: discountTypePicker)
        textFields[FieldType.conditionalDiscountType.rawValue].inputView = createDiscountTypePicker(with: conditionalDiscountTypePicker)
        textFields[FieldType.expireAt.rawValue].inputView = createDatePicker(action: #selector(handleExpireAtDatePickerChange(_:)))
        textFields[FieldType.contitionalDiscountDeadline.rawValue].inputView = createDatePicker(action: #selector(handleDeadlineDatePickerChange(_:)))
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
            guard let field = FieldType(rawValue: rawValue) else { return }
            guard let value = textFields[field.rawValue].text else { return }
            
            let validationLine = validationViews[field.rawValue]
               
            if value.isEmpty {
                validationLine.backgroundColor = Constants.Color.cinzaClaro
                
                if field == .discountValue {
                    validationViews[FieldType.discountType.rawValue].backgroundColor = Constants.Color.cinzaClaro
                }
                
                if field == .contitionalDiscountValue {
                    validationViews[FieldType.conditionalDiscountType.rawValue].backgroundColor = Constants.Color.cinzaClaro
                }
            }
            else if result == true {
                validationLine.backgroundColor = Constants.Color.verde
                
                if field == .discountValue {
                    validationViews[FieldType.discountType.rawValue].backgroundColor = Constants.Color.verde
                }
                
                if field == .contitionalDiscountValue {
                    validationViews[FieldType.conditionalDiscountType.rawValue].backgroundColor = Constants.Color.verde
                }
            } else {
                validationLine.backgroundColor = Constants.Color.vermelhoEscuro
                
                if field == .discountValue {
                    validationViews[FieldType.discountType.rawValue].backgroundColor = Constants.Color.vermelhoEscuro
                }
                
                if field == .contitionalDiscountValue {
                    validationViews[FieldType.conditionalDiscountType.rawValue].backgroundColor = Constants.Color.vermelhoEscuro
                }
            }
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
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: Helper.convertDateToReverseFormat($0) ?? $0)
                        self?.viewModel.expireAt = Helper.convertDateToReverseFormat($0) ?? $0
                        self?.chargeButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .shippingValue:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.shippingValue = $0
                        self?.totalLabel.text = self?.viewModel.total
                        self?.chargeButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .discountType:
                    textField.bind { [weak self] in
                        let value = $0 == "%" ? "percentage": "currency"
                        self?.viewModel.validadeField(field.rawValue, value: value)
                        self?.viewModel.discountType =  value
                        self?.totalLabel.text = self?.viewModel.total
                        self?.chargeButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .discountValue:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.discountValue = $0
                        self?.totalLabel.text = self?.viewModel.total
                        self?.chargeButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .conditionalDiscountType:
                    textField.bind { [weak self] in
                        let value = $0 == "%" ? "percentage": "currency"
                        self?.viewModel.validadeField(field.rawValue, value: value)
                        self?.viewModel.conditionalDiscountType = value
                        self?.totalLabel.text = self?.viewModel.total
                        self?.chargeButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .contitionalDiscountValue:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.conditionalDiscountValue = $0
                        self?.totalLabel.text = self?.viewModel.total
                        self?.chargeButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .contitionalDiscountDeadline:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: Helper.convertDateToReverseFormat($0) ?? $0)
                        self?.viewModel.conditionalDiscountDeadline = Helper.convertDateToReverseFormat($0) ?? $0
                        self?.chargeButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                }
            }
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
    
    func didSelectType(type: String) {
        guard let textField = textFields.first(where: { $0.isFirstResponder }) else {
            return
        }
        
        if (textField == textFields[FieldType.discountType.rawValue])
        || (textField == textFields[FieldType.conditionalDiscountType.rawValue]) {
            textField.replace(withText: type)
            textField.resignFirstResponder()
        }
    }
}
