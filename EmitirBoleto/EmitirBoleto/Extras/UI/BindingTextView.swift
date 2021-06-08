//
//  BindingTextView.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 08/06/21.
//

import UIKit

class BindingTextView: UITextView, UITextViewDelegate {
    
    var textChanged: (String) -> () = { _ in }
    
    func bind(callback: @escaping (String) -> ()) {
        self.textChanged = callback
        self.delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        self.textChanged(text)
    }
}
