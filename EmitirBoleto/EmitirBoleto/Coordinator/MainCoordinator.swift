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
        vc.setCustomer(customer)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func addItemPopup(to delegate: AddItemDelegate) {
        let vc = AddItemPopupViewController()
        vc.coordinator = self
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func searchItem(to delegate: SearchItemDelegate) {
        let vc = SearchItemViewController()
        vc.delegate = delegate
        vc.coordinator = self
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
