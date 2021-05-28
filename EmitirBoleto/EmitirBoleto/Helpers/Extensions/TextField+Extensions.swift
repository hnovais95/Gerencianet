//
//  BindingTextField.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 26/05/21.
//

import UIKit

extension UITextField {
    
    func replace(withText text: String) {
        self.text = ""
        self.insertText(text)
    }
}
