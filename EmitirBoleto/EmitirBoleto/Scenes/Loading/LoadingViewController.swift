//
//  LoadingViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 25/05/21.
//

import UIKit

class LoadingViewController: UIViewController {
    
    // MARK: Outlets
    
    
    
    // MARK: Member variables
    
    weak var coordinator: MainCoordinator?
    private var viewModel = LoadingViewModel()
    
    
    // MARK: Public methods
    
    func setRequiredData(_ data: ChargeOneStepModel) {
        viewModel.data = data
    }
    
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeEvents()
        viewModel.charge()
    }
    
    
    // MARK: Layout
    
    
    
    
    // MARK: Handlers
    
    private func observeEvents() {
        viewModel.succeed = { [unowned self] response in
            guard let data = viewModel.data else { return }
            let customerName = data.bankingBillet.customer.name
            self.coordinator?.showBankingBillet(to: customerName, withResponse: response)
        }
        
        viewModel.failed = { [unowned self] response in
            print(response)
            self.coordinator?.showErrorMessage(withMessage: response)
        }
    }
}
