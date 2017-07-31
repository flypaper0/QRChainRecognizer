//
//  QRCaptureService.swift
//  QRChainRecognizer
//
//  Created by Artur Guseinov on 28/07/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import AVFoundation

protocol QRCaptureServiceDelegate: class {
    func qrCaptureDidStart(session: AVCaptureSession)
    func qrCaptureDidFailed(with error: Error)
    func qrCaptureDidDetect(object: AVMetadataMachineReadableCodeObject?)
}

class QRCaptureService: NSObject {
    
    weak var delegate: QRCaptureServiceDelegate? {
        didSet {
            start()
        }
    }
    
    fileprivate var captureSession: AVCaptureSession?
    
    fileprivate func start() {
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureSession?.addOutput(captureMetadataOutput)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            delegate?.qrCaptureDidStart(session: captureSession!)
            captureSession?.startRunning()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func stop() {
        captureSession?.stopRunning()
    }

}

// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension QRCaptureService: AVCaptureMetadataOutputObjectsDelegate {
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {

        guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
            metadataObject.type == AVMetadataObjectTypeQRCode else {
            delegate?.qrCaptureDidDetect(object: nil)
            return
        }
        
        delegate?.qrCaptureDidDetect(object: metadataObject)
    }
    
}
