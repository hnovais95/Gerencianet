//
//  FailureViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 25/05/21.
//

import UIKit

class FailureViewController: UIViewController {
    
    // MARK: Outlets

    @IBOutlet weak var backButton: BackButton!
    @IBOutlet weak var errorMessageTextView: UITextView!
    
    
    // MARK: Member variables
    
    weak var coordinator: MainCoordinator?
    var message: String?
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backButton.addTarget(self, action: #selector(self.handleTapBackButton(_:)), for: .touchUpInside)
        
        setupLayout()
    }
    
    
    // MARK: Layout
    
    private func setupLayout() {
        errorMessageTextView.text = message?.uppercased()
    }
    
    
    // MARK: Handles
    
    @objc
    private func handleTapBackButton(_ sender: UIButton) {
        coordinator?.back()
    }
    
}
