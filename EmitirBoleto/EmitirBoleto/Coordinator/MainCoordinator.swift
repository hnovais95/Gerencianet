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
        let vc = InsertCustomerViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func searchCustomer(to delegate: SearchCustomerDelegate) {
        let vc = SearchCustomerViewController()
        vc.delegate = delegate
        vc.coordinator = self
        navigationController.present(vc, animated: true)
    }
    
    func addItems(to customer: CustomerModel) {
        let vc = AddItemsViewController()
        vc.setRequiredData(customer)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func searchItem(to delegate: SearchItemDelegate) {
        let vc = SearchItemViewController()
        vc.delegate = delegate
        vc.coordinator = self
        navigationController.present(vc, animated: true)
    }
    
    func addItemPopup(to delegate: AddItemDelegate) {
        let vc = AddItemPopupViewController()
        vc.delegate = delegate
        vc.coordinator = self
        navigationController.present(vc, animated: true)
    }
    
    func editItemPopup(to delegate: EditItemDelegate, withItem item: ItemModel) {
        let vc = EditItemPopupViewController()
        vc.delegate = delegate
        vc.coordinator = self
        navigationController.present(vc, animated: true)
        vc.prepare(withItem: item)
    }
    
    func configureBankingBillet(to customer: CustomerModel, with items: [ItemModel]) {
        let vc = BankingBilletViewController()
        vc.setRequiredData(customer, items)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func createCharge(with data: ChargeOneStepModel) {
        let vc = LoadingViewController()
        vc.setRequiredData(data)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showErrorMessage(with message: String) {
        let vc = FailureViewController()
        vc.message = message
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func backToConfigureBankingBillet() {
        if let vc = navigationController.viewControllers.first(where: { $0 is BankingBilletViewController }) {
            navigationController.popToViewController(vc, animated: true)
        }
    }
    
    func showBankingBillet(to customer: String, with response: ChargeOneStepResponse) {
        let vc = SuccessViewController()
        vc.customer = customer
        vc.response = response
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
