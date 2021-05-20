//
//  CustomerViewController+Extensions.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 20/05/21.
//

import UIKit

extension CustomerViewController {
    
    func setupSegmentedControl() {
        entityTypeSegmentedControl.layer.borderWidth = 1.0
        entityTypeSegmentedControl.layer.borderColor = UIColor.init(rgb: 0x00B4C5).cgColor
        entityTypeSegmentedControl.layer.masksToBounds = true
        
        entityTypeSegmentedControl.setBackgroundImage(UIImage(ciImage: .clear), for: .normal, barMetrics: .default)
        entityTypeSegmentedControl.setBackgroundImage(UIImage(color: UIColor(rgb: 0x00B4C5)), for: .selected, barMetrics: .default)

        entityTypeSegmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        entityTypeSegmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.init(rgb: 0x00B4C5)], for: .normal)
    }
}

extension CustomerViewController {
    
    func setupButtons() {
        backButton.layer.borderWidth = 1.0
        backButton.layer.borderColor = UIColor.init(rgb: 0xF36F36).cgColor
        
        nextButton.layer.borderWidth = 1.0
        nextButton.layer.borderColor = UIColor.init(rgb: 0x707070).cgColor
        nextButton.backgroundColor = UIColor.init(rgb: 0xB8B8B8)
        nextButton.setTitleColor(UIColor.init(rgb: 0xFFFFFF), for: .normal)
    }
}
