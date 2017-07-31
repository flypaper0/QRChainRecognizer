//
//  ChainingProtocol.swift
//  QRChainRecognizer
//
//  Created by Artur Guseinov on 28/07/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

protocol ChainingProtocol: JSONRepresentationProtocol {
    init(json: [String: Any]) throws
}

extension ChainingProtocol {
    
    init(chunks: [Chunk]) throws {
        
        let data = chunks.map { $0.payload }.data
        
        guard let json = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String: Any] else {
            throw ParsingError.bufferRestoring
        }
        
        try self.init(json: json)
    }
    
}

