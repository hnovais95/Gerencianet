//
//  BindingTextField.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 28/05/21.
//

import UIKit
import SwiftMaskText

class BindingTextField: SwiftMaskField  {
    
    var textChanged: (String) -> () = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.maskString = ""
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.maskString = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        draw(frame)
    }
    
    func bind(callback: @escaping (String) -> ()) {        
        self.textChanged = callback
        self.addTarget(self, action: #selector(onChange), for: .editingChanged)
    }
    
    @objc func onChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        self.textChanged(removeMaskCharacters(text: text, withMask: maskString))
    }    
}
