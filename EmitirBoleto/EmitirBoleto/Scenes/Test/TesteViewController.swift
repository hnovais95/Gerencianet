//
//  TesteViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 26/05/21.
//

import UIKit

class TesteViewController: UIViewController {

    @IBOutlet weak var textField: BindingTextField! {
        didSet {
            self.textField.bind { self.label.text = $0 }
        }
    }
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
