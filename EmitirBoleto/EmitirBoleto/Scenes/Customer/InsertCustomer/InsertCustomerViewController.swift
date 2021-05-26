//
//  CustomerViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 19/05/21.
//

import UIKit

class InsertCustomerViewController: UIViewController {
    
    private var viewModel = InsertCustomerViewModel()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var additionalFieldsSwitch: UISwitch!
    @IBOutlet weak var juridicalPersonStackView: UIStackView!
    @IBOutlet weak var additionalFieldsStackView: UIStackView!
    
    @IBOutlet weak var nameValidationView: UIView!
    @IBOutlet weak var cpfValidationView: UIView!
    @IBOutlet weak var corporateNameValidationView: UIView!
    @IBOutlet weak var cnpjValidationView: UIView!
    @IBOutlet weak var phoneNumberValidationView: UIView!
    @IBOutlet weak var emailValidationView: UIView!
    @IBOutlet weak var numberValidationView: UIView!
    @IBOutlet weak var streetValidationView: UIView!
    @IBOutlet weak var complementValidationView: UIView!
    @IBOutlet weak var neighborhoodValidationView: UIView!
    @IBOutlet weak var cityValidationView: UIView!
    @IBOutlet weak var zipcodeValidationView: UIView!
    @IBOutlet weak var stateValidationView: UIView!
    
    @IBOutlet weak var nameValidationMessageLabel: UILabel!
    @IBOutlet weak var cpfValidationMessageLabel: UILabel!
    @IBOutlet weak var corporateNameValidationMessageLabel: UILabel!
    @IBOutlet weak var cnpjValidationMessageLabel: UILabel!
    @IBOutlet weak var phoneNumberValidationMessageLabel: UILabel!
    @IBOutlet weak var emailValidationMessageLabel: UILabel!
    @IBOutlet weak var streetValidationMessageLabel: UILabel!
    @IBOutlet weak var numberValidationMessageLabel: UILabel!
    @IBOutlet weak var complementValidationMessageLabel: UILabel!
    @IBOutlet weak var neighborhoodValidationMessageLabel: UILabel!
    @IBOutlet weak var zipcodeValidationMessageLabel: UILabel!
    @IBOutlet weak var stateValidationMessageLabel: UILabel!
    @IBOutlet weak var cityValidationMessageLabel: UILabel!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cpfTextField: UITextField!
    @IBOutlet weak var corporateNameTextField: UITextField!
    @IBOutlet weak var cnpjTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var complementTextField: UITextField!
    @IBOutlet weak var neighborhoodTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!

    @IBOutlet weak var stateButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.addTarget(self, action: #selector(handleSegmentedControlChanged(_:)), for: .valueChanged)
        additionalFieldsSwitch.addTarget(self, action: #selector(handleSwitchChanged(_:)), for: .valueChanged)
        
        setupLayout()
        bindTextFields()
    }
    
    @objc
    private func handleSegmentedControlChanged(_ sender: UISegmentedControl) {
        juridicalPersonStackView.isHidden = sender.selectedSegmentIndex == 0
        viewModel.isJuridicalPerson = sender.selectedSegmentIndex == 0
    }
    
    @objc
    private func handleSwitchChanged(_ sender: UISwitch) {
        additionalFieldsStackView.isHidden = !sender.isOn
        viewModel.includeAddress = sender.isOn
    }
    
    private func setupLayout() {
        setupLayoutSegmentedControl()
        setupLayoutButtons()
        setupInitialStateOfControls()
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
    
    private func setupInitialStateOfControls() {
        additionalFieldsStackView.isHidden = true
        additionalFieldsSwitch.isOn = false
        
        juridicalPersonStackView.isHidden = true
        segmentedControl.selectedSegmentIndex = 0
    }
    
    private func bindTextFields() {
        nameTextField.bind { [weak self] in
            if Validator.isValid(.name, value: $0) {
                self?.viewModel.name = $0
                self?.nameValidationView.backgroundColor = UIColor.green
                self?.nameValidationMessageLabel.alpha = 1
            } else {
                self?.nameValidationView.backgroundColor = UIColor.red
                self?.nameValidationMessageLabel.alpha = 0
            }
        }
        cpfTextField.bind { [weak self] in self?.viewModel.cpf = $0 }
        corporateNameTextField.bind { [weak self] in self?.viewModel.corporateName = $0 }
        cnpjTextField.bind { [weak self] in self?.viewModel.cnpj = $0 }
        phoneNumberTextField.bind { [weak self] in self?.viewModel.phoneNumber = $0 }
        emailTextField.bind { [weak self] in self?.viewModel.email = $0 }
        streetTextField.bind { [weak self] in self?.viewModel.street = $0 }
        numberTextField.bind { [weak self] in self?.viewModel.number = Int($0) }
        complementTextField.bind { [weak self] in self?.viewModel.complement = $0 }
        neighborhoodTextField.bind { [weak self] in self?.viewModel.neighborhood = $0 }
        zipcodeTextField.bind { [weak self] in self?.viewModel.zipcode = $0 }
        stateTextField.bind { [weak self] in self?.viewModel.state = $0 }
        cityTextField.bind { [weak self] in self?.viewModel.city = $0 }
    }
}
