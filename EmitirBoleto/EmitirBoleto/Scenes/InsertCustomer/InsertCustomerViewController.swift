//
//  CustomerViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 19/05/21.
//

import Foundation
import UIKit

class InsertCustomerViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet var textFields: [BindingTextField]!
    @IBOutlet var validationViews: [UIView]!
    @IBOutlet var errorMessageLabels: [UILabel]!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var addressSwitch: UISwitch!
    @IBOutlet weak var searchCustomerButton: UIButton!
    @IBOutlet weak var statePickerButton: UIButton!
    @IBOutlet weak var backButton: BackButton!
    @IBOutlet weak var nextButton: NextButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var juridicalPersonStackView: UIStackView!
    @IBOutlet weak var addressStackView: UIStackView!
    
    
    // MARK: Member types
    
    private enum CustomerFieldType: Int, CaseIterable {
        case name, cpf, corporateName, cnpj, phoneNumber, email,
             street, number, complement, neighborhood, zipcode, state, city
    }
    
    
    // MARK: Member variables
    
    weak var coordinator: MainCoordinator?
    private var viewModel = InsertCustomerViewModel()
    private var statePickerView = StatePickerViewController()
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.addTarget(self, action: #selector(handleSegmentedControlChange(_:)), for: .valueChanged)
        addressSwitch.addTarget(self, action: #selector(handleSwitchChange(_:)), for: .valueChanged)
        nextButton.addTarget(self, action: #selector(handleNextStep), for: .touchUpInside)
        searchCustomerButton.addTarget(self, action: #selector(handleTapSearchCustomerButton), for: .touchUpInside)
        statePickerButton.addTarget(self, action: #selector(handleBeginSelectionState), for: .touchUpInside)
        textFields[CustomerFieldType.state.rawValue].addTarget(self, action: #selector(handleBeginSelectionState), for: .editingDidBegin)
        
        statePickerView.delegate = self
        
        setupLayout()
        bindTextFields()
        observeEvents()
    }
    
    
    // MARK: Layout
    
    private func setupInitialStateOfComponents() {
        juridicalPersonStackView.isHidden = true
        addressStackView.isHidden = true
        addressSwitch.setOn(false, animated: false)
        segmentedControl.selectedSegmentIndex = 0
    }
    
    private func setupLayoutSegmentedControl() {
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.layer.borderColor = Constants.Color.azulEscuro.cgColor
        segmentedControl.layer.masksToBounds = true
        segmentedControl.setBackgroundImage(UIImage(ciImage: .clear), for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(UIImage(color: Constants.Color.azulEscuro), for: .selected, barMetrics: .default)
        segmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: Constants.Color.azulEscuro], for: .normal)
    }
    
    private func setupLayout() {
        setupInitialStateOfComponents()
        setupLayoutSegmentedControl()
    }
    
    
    // MARK: Handlers
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func observeEvents() {
        viewModel.validatedField = { [unowned self] result, indexField in
            guard let field = CustomerFieldType(rawValue: indexField) else { return }
            guard let value = textFields[field.rawValue].text else { return }
            
            let validationLine = validationViews[field.rawValue]
            let errorMessage = field != .email ? errorMessageLabels[field.rawValue] : nil
               
            if value.isEmpty {
                validationLine.backgroundColor = Constants.Color.cinzaClaro
                errorMessage?.alpha = 0
            }
            else if result == true {
                validationLine.backgroundColor = Constants.Color.verde
                errorMessage?.alpha = 0
            } else {
                validationLine.backgroundColor = Constants.Color.vermelhoEscuro
                errorMessage?.alpha = 1
            }
        }
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector (keyboardWillBeShown(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector (keyboardWillBeHidden(_ :)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc
    private func handleSegmentedControlChange(_ sender: UISegmentedControl) {
        juridicalPersonStackView.isHidden = sender.selectedSegmentIndex == 0
        viewModel.isJuridicalPerson = sender.selectedSegmentIndex == 1
        self.nextButton.setEnable(viewModel.isValid)
    }
    
    @objc
    private func handleSwitchChange(_ sender: UISwitch) {
        addressStackView.isHidden = !sender.isOn
        viewModel.includeAddress = sender.isOn
        self.nextButton.setEnable(viewModel.isValid)
    }
    
    @objc
    private func handleNextStep() {
        if viewModel.isValid {
            let customer = viewModel.getCustomer()
            coordinator?.addItems(to: customer)
        }
    }
    
    @objc
    private func handleTapSearchCustomerButton() {
        coordinator?.searchCustomer(to: self)
    }
    
    @objc
    private func handleBeginSelectionState() {
        let pickerView = UIPickerView()
        pickerView.delegate = statePickerView
        pickerView.dataSource = statePickerView
        textFields[CustomerFieldType.state.rawValue].inputView = pickerView
        textFields[CustomerFieldType.state.rawValue].tintColor = .clear
        textFields[CustomerFieldType.state.rawValue].becomeFirstResponder()
    }
    
    @objc
    private func keyboardWillBeShown(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.height, right: 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        
        guard let textField = textFields.filter({ $0.isFocused }).first else { return }
        
        scrollView.scrollRectToVisible(textField.frame, animated: true)
    }
    
    @objc
    private func keyboardWillBeHidden(_ notification: Notification) {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    // MARK: Data binding
    
    private func bindTextFields() {
        for (index, textField) in textFields.enumerated() {
            if let field = CustomerFieldType(rawValue: index) {
                switch field {
                case .name:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.name = $0
                        self?.nextButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .cpf:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.cpf = $0
                        self?.nextButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .corporateName:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.corporateName = $0
                        self?.nextButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .cnpj:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.cnpj = $0
                        self?.nextButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .phoneNumber:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.phoneNumber = $0
                        self?.nextButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .email:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.email = $0
                        self?.nextButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .street:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.street = $0
                        self?.nextButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .number:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.number = $0
                        self?.nextButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .complement:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.complement = $0
                        self?.nextButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .neighborhood:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.neighborhood = $0
                        self?.nextButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .zipcode:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.zipcode = $0
                        self?.nextButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .state:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.state = $0
                        self?.nextButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                case .city:
                    textField.bind { [weak self] in
                        self?.viewModel.validadeField(field.rawValue, value: $0)
                        self?.viewModel.city = $0
                        self?.nextButton.setEnable(self?.viewModel.isValid ?? false)
                    }
                }
                
                textField.delegate = self
            }
        }
    }
}


// MARK: Delegates

extension InsertCustomerViewController: SearchCustomerDelegate {
    
    func didSelectCustomer(customer: CustomerModel) {
        textFields[CustomerFieldType.name.rawValue].replace(withText: customer.name)
        textFields[CustomerFieldType.cpf.rawValue].replace(withText: customer.cpf)
        textFields[CustomerFieldType.phoneNumber.rawValue].replace(withText: customer.phoneNumber)
        textFields[CustomerFieldType.email.rawValue].replace(withText: customer.email ?? "")
        
        if let juridicalPerson = customer.juridicalPerson {
            segmentedControl.selectedSegmentIndex = 1
            handleSegmentedControlChange(segmentedControl)
            
            textFields[CustomerFieldType.corporateName.rawValue].replace(withText: juridicalPerson.corporateName)
            textFields[CustomerFieldType.cnpj.rawValue].replace(withText: juridicalPerson.cnpj)
        } else {
            segmentedControl.selectedSegmentIndex = 0
            handleSegmentedControlChange(segmentedControl)
            
            textFields[CustomerFieldType.corporateName.rawValue].replace(withText: "")
            textFields[CustomerFieldType.cnpj.rawValue].replace(withText: "")
        }
        
        if let address = customer.address {
            addressSwitch.setOn(true, animated: true)
            handleSwitchChange(addressSwitch)
            
            textFields[CustomerFieldType.street.rawValue].replace(withText: address.street)
            textFields[CustomerFieldType.number.rawValue].replace(withText: address.number.description)
            textFields[CustomerFieldType.complement.rawValue].replace(withText: address.complement ?? "")
            textFields[CustomerFieldType.neighborhood.rawValue].replace(withText: address.neighborhood)
            textFields[CustomerFieldType.zipcode.rawValue].replace(withText: address.zipCode)
            textFields[CustomerFieldType.state.rawValue].replace(withText: address.state)
            textFields[CustomerFieldType.city.rawValue].replace(withText: address.city)
        } else {
            addressSwitch.setOn(false, animated: true)
            handleSwitchChange(addressSwitch)
            
            textFields[CustomerFieldType.street.rawValue].replace(withText: "")
            textFields[CustomerFieldType.number.rawValue].replace(withText: "")
            textFields[CustomerFieldType.complement.rawValue].replace(withText: "")
            textFields[CustomerFieldType.neighborhood.rawValue].replace(withText: "")
            textFields[CustomerFieldType.zipcode.rawValue].replace(withText: "")
            textFields[CustomerFieldType.state.rawValue].replace(withText: "")
            textFields[CustomerFieldType.city.rawValue].replace(withText: "")
        }
    }
}

extension InsertCustomerViewController: StatePickerViewDelegate {
    
    func didSelectState(state: String) {
        textFields[CustomerFieldType.state.rawValue].replace(withText: state)
        textFields[CustomerFieldType.city.rawValue].becomeFirstResponder()
    }
}

extension InsertCustomerViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var field: CustomerFieldType?
        for (index, _) in textFields.enumerated() {
            if textFields[index] == textField {
                field = CustomerFieldType(rawValue: index)
            }
        }
        
        guard var field = field else { return false }
        
        switch field {
        case .email, .city:
            handleNextStep()
            textFields[field.rawValue].resignFirstResponder()
        case .cpf, .cnpj, .phoneNumber, .number, .state:
            textFields[field.rawValue].resignFirstResponder()
        default:
            field.next()
            textFields[field.rawValue].becomeFirstResponder()
        }
        
        return true
    }
}
