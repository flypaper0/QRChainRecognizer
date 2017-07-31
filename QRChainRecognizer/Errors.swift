//
//  Errors.swift
//  QRChainRecognizer
//
//  Created by Artur Guseinov on 28/07/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

protocol CustomError: Error {
    typealias ErrorInfo = (title: String?, message: String?, showing: Bool)
    var description: ErrorInfo { get }
}

// MARK - Parsing errors

enum ParsingError: CustomError {
    
    case chunk
    case bufferRestoring
    case paymentInfo
    
    var description: ErrorInfo {
        switch self {
            
        case .chunk:
            return ("ParsingError", "Chain part parsing error", true)
            
        case .bufferRestoring:
            return ("ParsingError", "Buffer restoring error", true)
            
        case .paymentInfo:
            return ("ParsingError", "Payment info parsing error", true)
        }
        
    }
    
}

// MARK: - QRCode errors

enum QRCodeError: CustomError {
    
    case creationFromData
    
    var description: ErrorInfo {
        switch self {
            
        case .creationFromData:
            return ("QRCodeError", "Creation from data error", true)
        }
    }
    
}
