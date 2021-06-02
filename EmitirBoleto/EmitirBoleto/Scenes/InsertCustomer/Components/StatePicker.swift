//
//  StatePickerView.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 27/05/21.
//

import UIKit

protocol StatePickerDelegate: AnyObject {
    func didSelectState(state: String)
}

class StatePicker: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let states = ["AC", "AL", "AM", "AP", "BA", "CE", "DF",
                          "ES", "GO", "MA", "MT", "MS", "MG", "PA",
                          "PB", "PR", "PE", "PI", "RJ", "RN", "RO",
                          "RS", "RR", "SC", "SE", "SP", "TO"]
    
    weak var delegate: StatePickerDelegate?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.didSelectState(state: states[row])
    }
}
