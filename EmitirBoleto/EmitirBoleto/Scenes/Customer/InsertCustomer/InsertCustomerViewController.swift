//
//  CustomerViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 19/05/21.
//

import UIKit

class InsertCustomerViewController: UIViewController {
    
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var validationViews: [UIView]!
    @IBOutlet var errorMessageLabels: [UILabel]!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var addressSwitch: UISwitch!
    @IBOutlet weak var searchCustomerButton: UIButton!
    @IBOutlet weak var statePickerButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var juridicalPersonStackView: UIStackView!
    @IBOutlet weak var addressStackView: UIStackView!
    
    private enum FieldType: Int {
        case name, cpf, corporateName, cnpj, phoneNumber, email,
             street, number, complement, neighborhood, zipcode, state, city
    }
    
    weak var coordinator: MainCoordinator?
    private var viewModel = InsertCustomerViewModel()
    private var statePickerView = StatePickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.addTarget(self, action: #selector(handleSegmentedControlChange(_:)), for: .valueChanged)
        addressSwitch.addTarget(self, action: #selector(handleSwitchChange(_:)), for: .valueChanged)
        nextButton.addTarget(self, action: #selector(handleTapNextButton(_:)), for: .touchUpInside)
        searchCustomerButton.addTarget(self, action: #selector(handleTapSearchCustomerButton(_:)), for: .touchUpInside)
        statePickerButton.addTarget(self, action: #selector(handleBeginSelectionState(_:)), for: .touchUpInside)
        textFields[FieldType.state.rawValue].addTarget(self, action: #selector(handleBeginSelectionState(_:)), for: .editingDidBegin)
        
        statePickerView.delegate = self
        
        setupLayout()
        bindTextFields()
        observeEvents()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        UITextField.clearStoredCallbacksTextEditingChanged()
    }
    
    private func observeEvents() {
        viewModel.validatedField = { [weak self] result, indexField in
            guard let field = FieldType(rawValue: indexField) else { return }
            guard let value = self?.textFields[field.rawValue].text else { return }
            
            let validationLine = self?.validationViews[field.rawValue]
            let errorMessage = field != .email ? self?.errorMessageLabels[field.rawValue] : nil
               
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
    private func handleSegmentedControlChange(_ sender: UISegmentedControl) {
        juridicalPersonStackView.isHidden = sender.selectedSegmentIndex == 0
        viewModel.isJuridicalPerson = sender.selectedSegmentIndex == 1
        setupNextButtonState()
    }
    
    @objc
    private func handleSwitchChange(_ sender: UISwitch) {
        addressStackView.isHidden = !sender.isOn
        viewModel.includeAddress = sender.isOn
        setupNextButtonState()
    }
    
    @objc
    private func handleTapNextButton(_ sender: UIButton) {
        if viewModel.isValid {
            let customer = viewModel.getCustomer()
            coordinator?.addItems(to: customer)
        }
    }
    
    @objc
    private func handleTapSearchCustomerButton(_ sender: UIButton) {
        coordinator?.searchCustomer(to: self)
    }
    
    @objc
    private func handleBeginSelectionState(_ sender: Any) {
        let pickerView = UIPickerView()
        pickerView.delegate = statePickerView
        pickerView.dataSource = statePickerView
        textFields[FieldType.state.rawValue].inputView = pickerView
        textFields[FieldType.state.rawValue].tintColor = .clear
        textFields[FieldType.state.rawValue].becomeFirstResponder()
    }
    
    private func setupLayout() {
        setupInitialStateOfComponents()
        setupLayoutSegmentedControl()
        setupLayoutButtons()
    }
    
    private func setupLayoutSegmentedControl() {
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.layer.borderColor = Constants.Color.azul.cgColor
        segmentedControl.layer.masksToBounds = true
        segmentedControl.setBackgroundImage(UIImage(ciImage: .clear), for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(UIImage(color: Constants.Color.azul), for: .selected, barMetrics: .default)
        segmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: Constants.Color.azul], for: .normal)
    }
    
    private func setupLayoutButtons() {
        backButton.layer.borderWidth = 1.0
        backButton.layer.borderColor = Constants.Color.laranja.cgColor
        
        nextButton.layer.borderWidth = 1.0
        nextButton.layer.borderColor = Constants.Color.cinzaEscuro.cgColor
        nextButton.backgroundColor = Constants.Color.cinzaClaro
        nextButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    private func setupInitialStateOfComponents() {
        juridicalPersonStackView.isHidden = true
        addressStackView.isHidden = true
        addressSwitch.setOn(false, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        setupNextButtonState()
    }
    
    private func setupNextButtonState() {
        nextButton.isEnabled = viewModel.isValid
        nextButton.isHighlighted = !viewModel.isValid
    }
    
    private func bindTextFields() {
        for (index, textField) in textFields.enumerated() {
            if let field = FieldType(rawValue: index) {
                switch field {
                case .name:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.name = $0
                        self?.setupNextButtonState()
                    }
                case .cpf:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.cpf = $0
                        self?.setupNextButtonState()
                    }
                case .corporateName:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.corporateName = $0
                        self?.setupNextButtonState()
                    }
                case .cnpj:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.cnpj = $0
                        self?.setupNextButtonState()
                    }
                case .phoneNumber:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.phoneNumber = $0
                        self?.setupNextButtonState()
                    }
                case .email:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.email = $0
                        self?.setupNextButtonState()
                    }
                case .street:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.street = $0
                        self?.setupNextButtonState()
                    }
                case .number:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.number = $0
                        self?.setupNextButtonState()
                    }
                case .complement:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.complement = $0
                        self?.setupNextButtonState()
                    }
                case .neighborhood:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.neighborhood = $0
                        self?.setupNextButtonState()
                    }
                case .zipcode:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.zipcode = $0
                        self?.setupNextButtonState()
                    }
                case .state:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.state = $0
                        self?.setupNextButtonState()
                    }
                case .city:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.city = $0
                        self?.setupNextButtonState()
                    }
                }
            }
        }
    }
}

extension InsertCustomerViewController: SearchCustomerDelegate {
    
    func didFindCustomer(customer: CustomerModel) {
        textFields[FieldType.name.rawValue].replace(withText: customer.name)
        textFields[FieldType.cpf.rawValue].replace(withText: customer.cpf)
        textFields[FieldType.phoneNumber.rawValue].replace(withText: customer.phoneNumber)
        textFields[FieldType.email.rawValue].replace(withText: customer.email)
        
        if let juridicalPerson = customer.juridicalPerson {
            segmentedControl.selectedSegmentIndex = 1
            handleSegmentedControlChange(segmentedControl)
            
            textFields[FieldType.corporateName.rawValue].replace(withText: juridicalPerson.corporateName)
            textFields[FieldType.cnpj.rawValue].replace(withText: juridicalPerson.cnpj)
        }
        
        if let address = customer.address {
            addressSwitch.setOn(true, animated: true)
            handleSwitchChange(addressSwitch)
            
            textFields[FieldType.street.rawValue].replace(withText: address.street)
            textFields[FieldType.number.rawValue].replace(withText: address.number.description)
            textFields[FieldType.complement.rawValue].replace(withText: address.complement)
            textFields[FieldType.neighborhood.rawValue].replace(withText: address.neighborhood)
            textFields[FieldType.zipcode.rawValue].replace(withText: address.zipCode)
            textFields[FieldType.state.rawValue].replace(withText: address.state)
            textFields[FieldType.city.rawValue].replace(withText: address.city)
        }
    }
}

extension InsertCustomerViewController: StatePickerViewDelegate {
    
    func didSelectState(state: String) {
        textFields[FieldType.state.rawValue].replace(withText: state)
        textFields[FieldType.state.rawValue].resignFirstResponder()
    }
}
