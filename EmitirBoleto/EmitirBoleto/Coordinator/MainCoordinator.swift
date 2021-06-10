//
//  MainCoordinator.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 19/05/21.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func insertCustomer() {
        let vc = InsertCustomerViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func searchCustomer(to delegate: SearchCustomerDelegate) {
        let vc = SearchCustomerViewController()
        vc.coordinator = self
        vc.delegate = delegate
        navigationController.present(vc, animated: true)
    }
    
    func addItems(to customer: CustomerModel) {
        let vc = AddItemsViewController()
        vc.coordinator = self
        vc.setRequiredData(customer)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func searchItem(to delegate: SearchItemDelegate) {
        let vc = SearchItemViewController()
        vc.coordinator = self
        vc.delegate = delegate
        navigationController.present(vc, animated: true)
    }
    
    func addItemPopup(to delegate: AddItemDelegate) {
        let vc = AddItemPopupViewController()
        vc.coordinator = self
        vc.delegate = delegate
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        navigationController.present(vc, animated: true)
    }
    
    func editItemPopup(to delegate: EditItemDelegate, withItem item: ItemModel) {
        let vc = EditItemPopupViewController()
        vc.coordinator = self
        vc.delegate = delegate
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        navigationController.present(vc, animated: true)
        vc.prepare(withItem: item)
    }
    
    func configureBankingBillet(to customer: CustomerModel, with items: [ItemModel]) {
        let vc = BankingBilletViewController()
        vc.coordinator = self
        vc.setRequiredData(customer, items)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func createCharge(with data: ChargeOneStepModel) {
        let vc = LoadingViewController()
        vc.coordinator = self
        vc.setRequiredData(data)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showErrorMessage(with message: String) {
        let vc = FailureViewController()
        vc.coordinator = self
        vc.message = message
        navigationController.pushViewController(vc, animated: true)
    }
    
    func backToConfigureBankingBillet() {
        if let vc = navigationController.viewControllers.first(where: { $0 is BankingBilletViewController }) {
            navigationController.popToViewController(vc, animated: true)
        }
    }
    
    func showBankingBillet(to customer: String, with response: ChargeOneStepResponse) {
        let vc = SuccessViewController()
        vc.coordinator = self
        vc.customer = customer
        vc.response = response
        navigationController.pushViewController(vc, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
