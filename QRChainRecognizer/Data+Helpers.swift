//
//  Data+Helpers.swift
//  QRChainRecognizer
//
//  Created by Artur Guseinov on 30/07/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import CoreGraphics

extension Data {
    
    func buffer(chunkSize: Int) -> [Data] {
        
        var offset = 0
        var buffer = [Data]()
    
        repeat {
            let thisChunkSize = ((count - offset) > chunkSize) ? chunkSize : (count - offset);
            
            let chunk = subdata(in: offset..<offset + thisChunkSize)
            buffer.append(chunk)
            
            offset += thisChunkSize
        } while (offset < count)
        
        return buffer
    }
    
    func generateQRCodeImage() -> UIImage? {
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(self, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 4, y: 4)
            
            if let output = filter.outputImage?.applying(transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
}
