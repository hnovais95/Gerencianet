//
//  CustomButton.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 28/05/21.
//

import UIKit

class NextButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isEnabled = false
        setTitleColor(UIColor.white, for: .normal)
        layer.borderWidth = 1.0
        layer.borderColor = Constants.Color.cinzaEscuro.cgColor
        backgroundColor = Constants.Color.cinzaClaro
    }
    
    func setEnable(_ on: Bool) {
        isEnabled = on
        
        if isEnabled {
            layer.borderColor = Constants.Color.laranja.cgColor
            backgroundColor = Constants.Color.laranja
        } else {
            layer.borderColor = Constants.Color.cinzaEscuro.cgColor
            backgroundColor = Constants.Color.cinzaClaro
        }
    }
}

class BackButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTitleColor(Constants.Color.laranja, for: .normal)
        layer.borderWidth = 1.0
        layer.borderColor = Constants.Color.laranja.cgColor
        backgroundColor = UIColor.white
    }
}
