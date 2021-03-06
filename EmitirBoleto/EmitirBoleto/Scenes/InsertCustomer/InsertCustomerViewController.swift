//
//  CustomerViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 19/05/21.
//

import Foundation
import UIKit
import SwiftMaskText

class InsertCustomerViewController: UIViewController {
    
    // MARK: - Outlets
    
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
    
    
    // MARK: - Member types
    
    private enum FieldType: Int, CaseIterable {
        case name, cpf, corporateName, cnpj, phoneNumber, email,
             street, number, complement, neighborhood, zipCode, state, city
    }
    
    
    // MARK: - Member variables
    
    weak var coordinator: MainCoordinator?
    private var viewModel = InsertCustomerViewModel()
    private var statePicker = StatePicker()
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.segmentedControl.addTarget(self, action: #selector(handleSegmentedControlChange(_:)), for: .valueChanged)
        self.addressSwitch.addTarget(self, action: #selector(handleSwitchChange(_:)), for: .valueChanged)
        self.backButton.addTarget(self, action: #selector(handleBackStep), for: .touchUpInside)
        self.nextButton.addTarget(self, action: #selector(handleNextStep), for: .touchUpInside)
        self.searchCustomerButton.addTarget(self, action: #selector(handleTapSearchCustomerButton), for: .touchUpInside)
        self.statePickerButton.addTarget(self, action: #selector(handleTapStatePickerButton), for: .touchUpInside)
        
        statePicker.delegate = self
        scrollView.delegate = self
        
        setup()
        bindTextFields()
        observeEvents()
    }
    
    
    // MARK: - Setups
    
    private func setup() {
        setupSegmentedControl()
        setupStatePickerTextField()
        juridicalPersonStackView.isHidden = true
        addressStackView.isHidden = true
        addressSwitch.isOn = false
    }
    
    private func setupSegmentedControl() {
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.layer.borderColor = Constants.Color.gnDarkBlue.cgColor
        segmentedControl.layer.masksToBounds = true
        segmentedControl.setBackgroundImage(UIImage(ciImage: .clear), for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(UIImage(color: Constants.Color.gnDarkBlue), for: .selected, barMetrics: .default)
        segmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: Constants.Color.gnDarkBlue], for: .normal)
        segmentedControl.setTitleTextAttributes( [NSAttributedString.Key.font: UIFont(name: "SFProText-Regular", size: 13)!], for: .normal)
        segmentedControl.selectedSegmentIndex = 0
    }
    
    private func setupStatePickerTextField() {
        textFields[FieldType.state.rawValue].tintColor = .clear
        textFields[FieldType.state.rawValue].inputView = createStatePickerView()
    }
    
    
    // MARK: - Event handlers
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func observeEvents() {
        viewModel.validatedField = { [unowned self] result, indexField in
            guard let field = FieldType(rawValue: indexField) else { return }
            guard let value = textFields[field.rawValue].text else { return }
            
            let validationLine = validationViews[field.rawValue]
            let errorMessage = field != .email ? errorMessageLabels[field.rawValue] : nil
               
            if value.isEmpty {
                validationLine.backgroundColor = Constants.Color.gnLightGray
                errorMessage?.alpha = 0
            }
            else if result == true {
                validationLine.backgroundColor = Constants.Color.gnGreen
                errorMessage?.alpha = 0
            } else {
                validationLine.backgroundColor = Constants.Color.gnDarkRed
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
    private func handleBackStep() {
        coordinator?.back()
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
    private func handleTapStatePickerButton() {
        textFields[FieldType.state.rawValue].becomeFirstResponder()
    }
    
    @objc
    private func keyboardWillBeShown(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardScreenEndFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0.0)
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
    
    
    // MARK: - Data binding
    
    private func bindTextFields() {
        for (index, textField) in textFields.enumerated() {
            if let field = FieldType(rawValue: index) {
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
                    break
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
                case .zipCode:
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
    
    
    // MARK: - Methods
    
    private func createStatePickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = statePicker
        pickerView.dataSource = statePicker
        return pickerView
    }
}


// MARK: - Delegates

extension InsertCustomerViewController: SearchCustomerDelegate {
    
    func didSelectCustomer(_ customer: CustomerModel) {
        textFields[FieldType.name.rawValue].replace(withText: customer.name)
        textFields[FieldType.cpf.rawValue].replace(withText: Helper.applyMask(text: customer.cpf, maskString: Constants.Mask.cpf))
        textFields[FieldType.phoneNumber.rawValue].replace(withText: Helper.applyMask(text: customer.phoneNumber, maskString: Constants.Mask.phoneNumber))
        textFields[FieldType.email.rawValue].replace(withText: customer.email ?? "")
        
        if let juridicalPerson = customer.juridicalPerson {
            segmentedControl.selectedSegmentIndex = 1
            handleSegmentedControlChange(segmentedControl)
            
            textFields[FieldType.corporateName.rawValue].replace(withText: juridicalPerson.corporateName)
            textFields[FieldType.cnpj.rawValue].replace(withText: Helper.applyMask(text: juridicalPerson.cnpj, maskString: Constants.Mask.cnpj))
        } else {
            segmentedControl.selectedSegmentIndex = 0
            handleSegmentedControlChange(segmentedControl)
            
            textFields[FieldType.corporateName.rawValue].replace(withText: "")
            textFields[FieldType.cnpj.rawValue].replace(withText: "")
        }
        
        if let address = customer.address {
            addressSwitch.setOn(true, animated: true)
            handleSwitchChange(addressSwitch)
            
            textFields[FieldType.street.rawValue].replace(withText: address.street)
            textFields[FieldType.number.rawValue].replace(withText: address.number.description)
            textFields[FieldType.complement.rawValue].replace(withText: address.complement ?? "")
            textFields[FieldType.neighborhood.rawValue].replace(withText: address.neighborhood)
            textFields[FieldType.zipCode.rawValue].replace(withText: Helper.applyMask(text: address.zipCode, maskString: Constants.Mask.zipCode))
            textFields[FieldType.state.rawValue].replace(withText: address.state)
            textFields[FieldType.city.rawValue].replace(withText: address.city)
        } else {
            addressSwitch.setOn(false, animated: true)
            handleSwitchChange(addressSwitch)
            
            textFields[FieldType.street.rawValue].replace(withText: "")
            textFields[FieldType.number.rawValue].replace(withText: "")
            textFields[FieldType.complement.rawValue].replace(withText: "")
            textFields[FieldType.neighborhood.rawValue].replace(withText: "")
            textFields[FieldType.zipCode.rawValue].replace(withText: "")
            textFields[FieldType.state.rawValue].replace(withText: "")
            textFields[FieldType.city.rawValue].replace(withText: "")
        }
    }
}

extension InsertCustomerViewController: StatePickerDelegate {
    
    func didSelectState(state: String) {
        textFields[FieldType.city.rawValue].becomeFirstResponder()
        textFields[FieldType.state.rawValue].replace(withText: state)
    }
}

extension InsertCustomerViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var field: FieldType?
        for (index, _) in textFields.enumerated() {
            if textFields[index] == textField {
                field = FieldType(rawValue: index)
            }
        }
        
        guard var field = field else { return false }
        
        switch field {
        case .email, .cpf, .cnpj, .phoneNumber, .number, .state, .city:
            textFields[field.rawValue].resignFirstResponder()
        default:
            field.next()
            textFields[field.rawValue].becomeFirstResponder()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if textField == textFields[FieldType.cpf.rawValue] { return updatedText.count <= 14 }
        if textField == textFields[FieldType.cnpj.rawValue] { return updatedText.count <= 18 }
        else { return true }
    }
}

extension InsertCustomerViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0
    }
}
