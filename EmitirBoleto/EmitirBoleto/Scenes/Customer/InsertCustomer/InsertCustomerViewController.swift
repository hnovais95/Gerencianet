//
//  CustomerViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 19/05/21.
//

import UIKit

class InsertCustomerViewController: UIViewController {
    
    private var viewModel: InsertCustomerViewModel = InsertCustomerViewModel()
    
    @IBOutlet weak var entityTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var juridicalPersonStackView: UIStackView!
    @IBOutlet weak var showAdditionalFieldsSwitch: UISwitch!
    
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
        
        setupSegmentedControl()
        setupButtons()
        setupTextFields()
    }
    
    private func setupSegmentedControl() {
        entityTypeSegmentedControl.layer.borderWidth = 1.0
        entityTypeSegmentedControl.layer.borderColor = Constants.Color.azul.cgColor
        entityTypeSegmentedControl.layer.masksToBounds = true
        
        entityTypeSegmentedControl.setBackgroundImage(UIImage(ciImage: .clear), for: .normal, barMetrics: .default)
        entityTypeSegmentedControl.setBackgroundImage(UIImage(color: Constants.Color.azul), for: .selected, barMetrics: .default)

        entityTypeSegmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        entityTypeSegmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: Constants.Color.azul], for: .normal)
    }
    
    private func setupButtons() {
        backButton.layer.borderWidth = 1.0
        backButton.layer.borderColor = Constants.Color.laranja.cgColor
        
        nextButton.layer.borderWidth = 1.0
        nextButton.layer.borderColor = Constants.Color.cinzaEscuro.cgColor
        nextButton.backgroundColor = Constants.Color.cinzaClaro
        nextButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    private func setupTextFields() {
        nameTextField.bind { [weak self] in self?.viewModel.name = $0 }
    }
}


