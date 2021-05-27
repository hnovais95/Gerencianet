//
//  FailureViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 25/05/21.
//

import UIKit

class FailureViewController: UIViewController {
    
    // MARK: Outlets

    @IBOutlet weak var backButton: UIButton!
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
    }
    
    
    // MARK: Layout
    
    func setupButton() {
        backButton.layer.borderWidth = 1.0
        backButton.layer.borderColor = Constants.Color.laranja.cgColor
    }
}
