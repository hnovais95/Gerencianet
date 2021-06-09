//
//  HomeViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 08/06/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var button: UIButton!
    
    
    // MARK: - Member variables
    
    weak var coordinator: MainCoordinator?
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.button.addTarget(self, action: #selector(handleTapButton(_:)), for: .touchUpInside)
    }
    
    
    // MARK: - Handlers
    
    @objc
    private func handleTapButton(_ sender: UIButton) {
        coordinator?.insertCustomer()
    }
}
