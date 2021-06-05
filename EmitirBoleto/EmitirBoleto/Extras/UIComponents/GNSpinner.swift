//
//  GNSpinner.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 04/06/21.
//

import UIKit

class GNSpinner: UIView {
    
    let spinnerImageView = UIImageView(image: UIImage(named: "spinner"))
    let gnLogo = UIImageView(image: UIImage(named: "spinner_center_gn_logo"))
    var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        configureSpinner()
        configureLogo()
    }
    
    private func configureSpinner() {
        self.addSubview(spinnerImageView)
        spinnerImageView.center = self.center
        spinnerImageView.frame.size.height = frame.height
        spinnerImageView.frame.size.width = frame.width
    }
    
    private func configureLogo() {
        self.addSubview(gnLogo)
        gnLogo.center = self.center
        gnLogo.frame.size.height = 55
        gnLogo.frame.size.width = 60
    }
    
    func startAnimating() {
        spinnerImageView.isHidden = false
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
        }
    }
    
    func stopAnimating() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func animateView() {
        UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveLinear, animations: {
            self.spinnerImageView.transform = self.spinnerImageView.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { (finished) in
            if self.timer != nil {
                self.timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
            }
        })
    }
}

