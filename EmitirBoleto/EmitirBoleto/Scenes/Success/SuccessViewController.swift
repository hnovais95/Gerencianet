//
//  SuccessViewController.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 25/05/21.
//

import UIKit
import PDFKit

class SuccessViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet var labels: [UILabel]!
    @IBOutlet weak var barcodeTextView: UITextView!
    @IBOutlet weak var copyBarcodeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var showBankingBilletButton: UIButton!
    @IBOutlet weak var doneButton: NextButton!
    
    var closePdfButton: UIButton?
    
    
    // MARK: - Member types
    
    enum FieldType: Int, CaseIterable {
        case expireAt, value, customer
    }
    
    
    // MARK: - Member variables
    
    weak var coordinator: MainCoordinator?
    var response: ChargeOneStepResponse?
    var customer: String?
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.copyBarcodeButton.addTarget(self, action: #selector(self.handleTapCopyBarcodeButton(_:)), for: .touchUpInside)
        self.shareButton.addTarget(self, action: #selector(self.handleTapShareButton(_:)), for: .touchUpInside)
        self.showBankingBilletButton.addTarget(self, action: #selector(self.handleTapShowBankingBilletButton(_:)), for: .touchUpInside)
        self.doneButton.addTarget(self, action: #selector(self.handleTapDoneButton(_:)), for: .touchUpInside)

        setupButtons()
        prepare()
    }
    
    
    // MARK: - Setups
    
    private func setupButtons() {
        copyBarcodeButton.layer.borderWidth = 1.0
        copyBarcodeButton.layer.borderColor = Constants.Color.azulEscuro.cgColor
        
        shareButton.layer.borderWidth = 1.0
        shareButton.layer.borderColor = Constants.Color.azulEscuro.cgColor
        
        showBankingBilletButton.layer.borderWidth = 1.0
        showBankingBilletButton.layer.borderColor = Constants.Color.azulEscuro.cgColor
        
        doneButton.setEnable(true)
    }
    
    private func prepare() {
        guard let response = self.response, let customer = self.customer else { return }
        labels[FieldType.expireAt.rawValue].text = Helper.convertDateToNormalFormat(response.data.expireAt)
        labels[FieldType.value.rawValue].text = Helper.getPrice(response.data.total)
        labels[FieldType.customer.rawValue].text = customer
        barcodeTextView.text = response.data.barcode
    }
    
    
    private func addCloseButton(in superview: UIView) {
        closePdfButton = UIButton(type: .close)
        closePdfButton?.frame = CGRect(x: 0, y: 25, width: 50, height: 50)
        closePdfButton?.isHidden = true
        
        superview.addSubview(closePdfButton!)
        
        let guide = superview.safeAreaLayoutGuide
        closePdfButton?.translatesAutoresizingMaskIntoConstraints = false
        closePdfButton?.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 8).isActive = true
        closePdfButton?.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        
        closePdfButton?.addTarget(self, action: #selector(handleTapClosePdfButton), for: .touchUpInside)
    }
    
    
    // MARK: - Handles
    
    @objc
    private func handleTapCopyBarcodeButton(_ sender: UIButton) {
        sender.titleLabel?.isHighlighted = true
        UIPasteboard.general.string = response?.data.barcode
    }
    
    @objc
    private func handleTapShareButton(_ sender: UIButton) {
        guard let message = response?.data.shareableMessage else { return }
        let activityViewController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    @objc
    private func handleTapShowBankingBilletButton(_ sender: UIButton) {
        let pdfView = PDFView(frame: view.bounds)
        addCloseButton(in: pdfView)
        view.addSubview(pdfView)
        
        showSpinner()
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: self.response!.data.pdf.charge), let document = PDFDocument(url: url) {
                DispatchQueue.main.async {
                    pdfView.autoScales = true
                    pdfView.document = document
                    self.removeSpinner()
                    self.closePdfButton?.isHidden = false
                }
            } else {
                DispatchQueue.main.async {
                    self.removeSpinner()
                    self.closePdfButton?.isHidden = false
                }
            }
        }
    }
    
    @objc
    private func handleTapClosePdfButton() {
        if let pdfView = self.view.subviews.first(where: { $0 is PDFView }) {
            pdfView.removeFromSuperview()
        }
    }
    
    @objc
    private func handleTapDoneButton(_ sender: UIButton) {
        coordinator?.start()
    }
}
