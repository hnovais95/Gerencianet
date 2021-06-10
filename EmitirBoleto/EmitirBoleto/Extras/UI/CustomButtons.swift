//
//  CustomButtons.swift
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
        layer.borderColor = Constants.Color.gnDarkGray.cgColor
        backgroundColor = Constants.Color.gnLightGray
    }
    
    func setEnable(_ on: Bool) {
        isEnabled = on
        
        if isEnabled {
            layer.borderColor = Constants.Color.gnOrange.cgColor
            backgroundColor = Constants.Color.gnOrange
        } else {
            layer.borderColor = Constants.Color.gnDarkGray.cgColor
            backgroundColor = Constants.Color.gnLightGray
        }
    }
}

class BackButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTitleColor(Constants.Color.gnOrange, for: .normal)
        layer.borderWidth = 1.0
        layer.borderColor = Constants.Color.gnOrange.cgColor
        backgroundColor = UIColor.white
    }
}
