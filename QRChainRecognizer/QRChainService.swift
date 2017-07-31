//
//  QRChainService.swift
//  QRChainRecognizer
//
//  Created by Artur Guseinov on 30/07/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

protocol QRChainServiceDelegate: class {
    func qrChainDidGenerate(qrCodes: [UIImage])
    func qrChainDidFailed(with error: Error)
}

class QRChainService {
        
    weak var delegate: QRChainServiceDelegate?
    
    func createChain(from object: ChainingProtocol) {
        DispatchQueue.global().async { [weak self] in
            
            guard let strongSelf = self else { return }
            
            let data = NSKeyedArchiver.archivedData(withRootObject: object.json)
            let buffer = data.buffer(chunkSize: Constants.chunkSize)
            let chunks = buffer.enumerated().map { Chunk(index: $0.offset, count: buffer.count, payload: $0.element) }
            
            let qrCodes = chunks
                .map { element -> UIImage? in
                    let archivedData = NSKeyedArchiver.archivedData(withRootObject: element.json)
                    let stringRepresentation = archivedData.base64EncodedString()
                    let utf8Data = stringRepresentation.data(using: String.Encoding.utf8)
                    return utf8Data?.generateQRCodeImage()
                }
                .flatMap { $0 }
            
            guard chunks.count == qrCodes.count else {
                DispatchQueue.main.async {
                    strongSelf.delegate?.qrChainDidFailed(with: QRCodeError.creationFromData)
                }
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.delegate?.qrChainDidGenerate(qrCodes: qrCodes)
            }
        }
        
    }

}
