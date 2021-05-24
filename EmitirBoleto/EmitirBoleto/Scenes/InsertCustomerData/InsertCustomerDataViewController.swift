//
//  CustomerViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 19/05/21.
//

import UIKit

class InsertCustomerDataViewController: UIViewController {
    
    @IBOutlet weak var entityTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentedControl()
        setupButtons()
    }
}

extension InsertCustomerDataViewController {
    
    func setupSegmentedControl() {
        entityTypeSegmentedControl.layer.borderWidth = 1.0
        entityTypeSegmentedControl.layer.borderColor = Constants.Color.azul.cgColor
        entityTypeSegmentedControl.layer.masksToBounds = true
        
        entityTypeSegmentedControl.setBackgroundImage(UIImage(ciImage: .clear), for: .normal, barMetrics: .default)
        entityTypeSegmentedControl.setBackgroundImage(UIImage(color: Constants.Color.azul), for: .selected, barMetrics: .default)

        entityTypeSegmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        entityTypeSegmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: Constants.Color.azul], for: .normal)
    }
    
    func setupButtons() {
        backButton.layer.borderWidth = 1.0
        backButton.layer.borderColor = Constants.Color.laranja.cgColor
        
        nextButton.layer.borderWidth = 1.0
        nextButton.layer.borderColor = Constants.Color.cinzaEscuro.cgColor
        nextButton.backgroundColor = Constants.Color.cinzaClaro
        nextButton.setTitleColor(UIColor.white, for: .normal)
    }
}


