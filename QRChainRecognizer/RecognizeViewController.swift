//
//  RecognizeViewController.swift
//  QRChainRecognizer
//
//  Created by Artur Guseinov on 28/07/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import AVFoundation

class RecognizeViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    
    fileprivate let qrCaptureService = QRCaptureService()
    fileprivate let qrChainRestoreService = QRChainRestoreService<PaymentInfo>()
    fileprivate var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    fileprivate lazy var qrCodeFrameView: UIView = {
        let qrCodeFrameView = UIView()
        qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
        qrCodeFrameView.layer.borderWidth = 2
        self.view.addSubview(qrCodeFrameView)
        self.view.bringSubview(toFront: qrCodeFrameView)
        return qrCodeFrameView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        qrCaptureService.delegate = self
        qrChainRestoreService.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? PaymentInfoViewController, let paymentInfo = sender as? PaymentInfo else {
            return
        }
        destination.paymentInfo = paymentInfo
    }
    
}

// MARK: - QRCaptureDelegate

extension RecognizeViewController: QRCaptureServiceDelegate {
    
    func qrCaptureDidDetect(object: AVMetadataMachineReadableCodeObject?) {
        guard let object = object, let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: object) else {
            qrCodeFrameView.frame = CGRect.zero
            return
        }
        
        qrCodeFrameView.frame = barCodeObject.bounds
        qrChainRestoreService.updateChain(dataString: object.stringValue)
    }

    
    func qrCaptureDidStart(session: AVCaptureSession) {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        view.bringSubview(toFront: progressView)
    }
    
    
    func qrCaptureDidFailed(with error: Error) {
        print(error.localizedDescription)
    }
    
}

// MARK: - QRChainRestoreServiceDelegate

extension RecognizeViewController: QRChainRestoreServiceDelegate {
    
    func qrChunkRestoringFineshed(object: ChainingProtocol) {
        guard let paymentInfo = object as?  PaymentInfo else {
            return
        }
        
        qrCaptureService.stop()
        
        performSegue(withIdentifier: "showPaymentInfoViewController", sender: paymentInfo)
    }
    
    func qrChainRestoringDidChange(progress: Float) {
        progressView.progress = progress
    }
    
    func qrChunkRestoring(error: Error) {
        print(error.localizedDescription)
    }
    
}
