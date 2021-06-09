//
//  DecimalTextField.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 07/06/21.
//
//  Adapted by: https://github.com/atticus183/WorkingWithCurrencies/blob/master/WorkingWithCurrencies/CurrencyTextField.swift

import UIKit

class FractionalNumberTextField: UITextField {
    
    var passTextFieldText: ((String, Double?) -> Void)?
    
    var cleanedText: String {
        var cleanedAmount = ""

        for character in self.text ?? "" {
            if character.isNumber {
                cleanedAmount.append(character)
            }
        }

        return cleanedAmount
    }
    
    //Used to send clean double value back
    private var amountAsDouble: Double?
    
    var startingValue: Double? {
        didSet {
            let nsNumber = NSNumber(value: startingValue ?? 0.0)
            self.text = numberFormatter.string(from: nsNumber)
        }
    }
    
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    func setRegionCode(_ regionCode: String) {
        numberFormatter.locale = Locale(identifier: regionCode)
    }
    
    private var roundingPlaces: Int {
        return numberFormatter.maximumFractionDigits
    }
    
    private var isSymbolOnRight = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //If using in SBs
        setup()
    }
    
    private func setup() {
        //self.textAlignment = .right
        self.keyboardType = .numberPad
        self.contentScaleFactor = 0.5
        delegate = self
        
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    //AFTER entered string is registered in the textField
    @objc private func textFieldDidChange() {
        updateTextField()
    }
    
    //Placed in separate method so when the user selects an account with a different currency, it will immediately be reflected
    private func updateTextField() {
        var cleanedAmount = cleanedText
        
        if isSymbolOnRight {
            cleanedAmount = String(cleanedAmount.dropLast())
        }
        
        //Format the number based on number of decimal digits
        let amount = Double(cleanedAmount) ?? 0.0
        amountAsDouble = (amount / 100.0)
        let amountAsString = numberFormatter.string(from: NSNumber(value: amountAsDouble ?? 0.0)) ?? ""
        self.text = amountAsString
        
        passTextFieldText?(cleanedAmount, amountAsDouble)
    }
    
    //Prevents the user from moving the cursor in the textField
    //Source: https://stackoverflow.com/questions/16419095/prevent-user-from-setting-cursor-position-on-uitextfield
    override func closestPosition(to point: CGPoint) -> UITextPosition? {
        let beginning = self.beginningOfDocument
        let end = self.position(from: beginning, offset: self.text?.count ?? 0)
        return end
    }
}


extension FractionalNumberTextField: UITextFieldDelegate {
    
    //BEFORE entered string is registered in the textField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let lastCharacterInTextField = (textField.text ?? "").last
        
        //Note - not the most straight forward implementation but this subclass supports both right and left currencies
        if string == "" && lastCharacterInTextField!.isNumber == false {
            //For hitting backspace and currency is on the right side
            isSymbolOnRight = true
        } else {
            isSymbolOnRight = false
        }
        
        return true
    }
}
