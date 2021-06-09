//
//  LoadingViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 25/05/21.
//

import UIKit

class LoadingViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var spinnerImageView: UIImageView!
    
    
    // MARK: - Member variables
    
    weak var coordinator: MainCoordinator?
    private var viewModel = LoadingViewModel()
    var timer: Timer?
    
    
    // MARK: - Public methods
    
    func setRequiredData(_ data: ChargeOneStepModel) {
        viewModel.data = data
    }
    
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAnimating()
        observeEvents()
        viewModel.charge()
    }
    
    
    // MARK: - Handlers
    
    private func observeEvents() {
        viewModel.succeed = { [unowned self] response in
            guard let data = viewModel.data else { return }
            let customerName = data.bankingBillet.customer.name
            self.coordinator?.showBankingBillet(to: customerName, with: response)
            stopAnimating()
        }
        
        viewModel.failed = { [unowned self] response in
            print(response)
            self.coordinator?.showErrorMessage(with: response)
            stopAnimating()
        }
    }
    
    private func startAnimating() {
        spinnerImageView.isHidden = false
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
        }
    }
    
    private func stopAnimating() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func animateView() {
        UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveLinear, animations: {
            self.spinnerImageView.transform = self.spinnerImageView.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { (finished) in
            if self.timer != nil {
                self.timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
            }
        })
    }
}
