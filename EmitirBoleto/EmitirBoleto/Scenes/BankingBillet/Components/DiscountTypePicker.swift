//
//  DiscountTypePicker.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 02/06/21.
//

import UIKit

protocol DiscountTypePickerDelegate: AnyObject {
    func didSelectType(type: DiscountType)
}

class DiscountTypePicker: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let types: [DiscountType] = [.percentage, .currency]
    
    weak var delegate: DiscountTypePickerDelegate?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.didSelectType(type: types[row])
    }
}
