//
//  ItemDetailsTableViewCell.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 24/05/21.
//

import UIKit

protocol ItemDetailsDelegate {
    
    func didLongPress(item: ItemModel)
}

class ItemDetailsTableViewCell: UITableViewCell {    
    
    // MARK: Initializer
    
    static let identifier = "ItemDetailsTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    // MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    
    // MARK: Member variables
    
    var item: ItemModel?
    var delegate: ItemDetailsDelegate?
    
    
    // MARK: Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
        setupLongPressGesture()
    }
    
    
    // MARK: Setups
    
    func setup() {
        view.layer.borderWidth = 1.0
        view.layer.borderColor = Constants.Color.gnLightGray.cgColor
    }
    
    func setupLongPressGesture() {
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0.5 // 0.5 second press
        longPressGesture.delegate = self
        addGestureRecognizer(longPressGesture)
    }
    
    
    // MARK: Handlers
    
    func prepare(with item: ItemModel) {
        self.item = item
        nameLabel.text = item.name
        valueLabel.text = Helper.getPrice(item.value)
        amountLabel.text = item.amount.description
        totalLabel.text = Helper.getPrice(item.total)
    }
    
    @objc
    func handleLongPress() {
        guard let item = item else { return }
        delegate?.didLongPress(item: item)
    }
}
