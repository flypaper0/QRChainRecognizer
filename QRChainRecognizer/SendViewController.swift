//
//  SendViewController.swift
//  QRChainRecognizer
//
//  Created by Artur Guseinov on 28/07/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

class SendViewController: UIViewController {
    
    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    
    let paymentInfo = PaymentInfo(paymentId: "1FcgaxayTtATwtT91348jbg7xoGwTZ8fDu", nickname: "levLesh", avatar: #imageLiteral(resourceName: "Lev-Leshhenko"))
    
    let qrChainService = QRChainService()
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        qrChainService.delegate = self
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        sender.loadingIndicator(true)
        qrChainService.createChain(from: paymentInfo)
    }
}

// MARK: - QRChainServiceDelegate

extension SendViewController: QRChainServiceDelegate {
    
    func qrChainDidGenerate(qrCodes: [UIImage]) {
        sendButton.loadingIndicator(false)
        
        qrCodeImageView.animationImages = qrCodes
        qrCodeImageView.animationDuration = TimeInterval(Double(qrCodes.count) * Constants.gifImageIterval)
        qrCodeImageView.startAnimating()
    }

    
    func qrChainDidFailed(with error: Error) {
        print(error.localizedDescription)
    }
    
}
