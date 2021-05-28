//
//  BindingTextField.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 28/05/21.
//

import UIKit

class BindingTextField: UITextField {
    
    var textChanged: (String) -> () = { _ in }
    
    func bind(callback :@escaping (String) -> ()) {        
        self.textChanged = callback
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField :UITextField) {
        guard let text = textField.text else { return }
        self.textChanged(text)
    }    
}
