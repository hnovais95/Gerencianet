//
//  UIViewController+Extensions.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 04/06/21.
//

import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    
    func showSpinner() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        aView = UIView(frame: appDelegate.window!.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        //let ai = UIActivityIndicatorView(style: .large)
        let ai = GNSpinner()
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    
    func removeSpinner() {
        if let ai = aView?.subviews.first as? GNSpinner {
            ai.stopAnimating()
        }
        aView?.removeFromSuperview()
        aView = nil
    }
}
