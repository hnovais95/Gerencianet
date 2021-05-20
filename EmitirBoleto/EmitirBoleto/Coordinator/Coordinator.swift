//
//  Coordinator.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 19/05/21.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get set }
    
    func start()
}
