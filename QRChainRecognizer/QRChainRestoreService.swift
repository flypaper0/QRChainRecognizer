//
//  QRChainRestoreService.swift
//  QRChainRecognizer
//
//  Created by Artur Guseinov on 30/07/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

protocol QRChainRestoreServiceDelegate: class {
    func qrChunkRestoringFineshed(object: ChainingProtocol)
    func qrChainRestoringDidChange(progress: Float)
    func qrChunkRestoring(error: Error)
}

class QRChainRestoreService<T: ChainingProtocol> {
    
    typealias ChainingObject = T
    
    weak var delegate: QRChainRestoreServiceDelegate?
    
    fileprivate var buffer = Set<Chunk>() {
        didSet {
            checkBuffer()
            checkProgress()
        }
    }
    
    func updateChain(dataString: String) {
        
        guard let data = Data(base64Encoded: dataString) else {
            delegate?.qrChunkRestoring(error: ParsingError.chunk)
            return
        }
        
        do {
            buffer.insert(try Chunk(data: data))
        } catch {
            delegate?.qrChunkRestoring(error: error)
        }
    }
    
    fileprivate func checkBuffer() {
        
        guard let firstChank = buffer.first, buffer.count == firstChank.count else {
            return
        }
        
        do {
            let sortedChunks = [Chunk](buffer).sorted { $0.0.index < $0.1.index }
            delegate?.qrChunkRestoringFineshed(object: try ChainingObject(chunks: sortedChunks))
        } catch {
            delegate?.qrChunkRestoring(error: error)
        }
    }
    
    fileprivate func checkProgress() {
        guard let firstChunk = buffer.first else {
            return
        }
        
        delegate?.qrChainRestoringDidChange(progress: Float(buffer.count) / Float(firstChunk.count))
    }

}
