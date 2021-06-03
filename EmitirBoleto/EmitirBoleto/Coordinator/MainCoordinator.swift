//
//  MainCoordinator.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 19/05/21.
//

import Foundation
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
        navigationController.present(vc, animated: true, completion: nil)
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
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func addItemPopup(to delegate: AddItemDelegate) {
        let vc = AddItemPopupViewController()
        vc.delegate = delegate
        vc.coordinator = self
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func editItemPopup(to delegate: EditItemDelegate, withItem item: ItemModel) {
        let vc = EditItemPopupViewController()
        vc.delegate = delegate
        vc.coordinator = self
        navigationController.present(vc, animated: true) {
            vc.setItem(item)
        }
    }
    
    func configureBankingBillet(to customer: CustomerModel, with items: [ItemModel]) {
        let vc = BankingBilletViewController()
        vc.setRequiredData(customer, items)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func createCharge(withData data: ChargeOneStepModel) {
        let vc = LoadingViewController()
        vc.setRequiredData(data)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showBankingBillet(to customer: String, withResponse response: ChargeOneStepResponse) {
        let vc = SuccessViewController()
        vc.coordinator = self
        vc.customer = customer
        vc.response = response
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showErrorMessage(withMessage message: String) {
        let vc = FailureViewController()
        vc.coordinator = self
        vc.message = message
        navigationController.pushViewController(vc, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
